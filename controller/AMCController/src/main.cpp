#include <WiFi.h>
#include <ESPAsyncWebServer.h>
#include <MD_Parola.h>
#include <MD_MAX72XX.h>
#include <SPI.h>
#include <ArduinoFFT.h>

// Configuration de la matrice LED
#define HARDWARE_TYPE MD_MAX72XX::FC16_HW
#define MAX_DEVICES 4
#define CS_PIN 5

MD_Parola parola = MD_Parola(HARDWARE_TYPE, CS_PIN, MAX_DEVICES);

// Configuration du microphone
#define MIC_PIN 33
#define SAMPLES 64
#define SAMPLING_FREQUENCY 1000
double vReal[SAMPLES];
double vImag[SAMPLES];
ArduinoFFT<double> FFT;

// Variables pour les modes d’affichage
bool isDisplayingMessage = false;
bool isDisplayingSpectrum = false;
unsigned long messageTimeout = 0;
unsigned long spectrometerTimeout = 0;
int currentHour = 12;
int currentMinute = 30;
unsigned long lastTimeUpdate = 0;

// Configuration WiFi
const char *ssid = "ESP32_Matrix";
const char *password = "12345678";
AsyncWebServer server(80);

// Prototypes
void displayTime();
void displayMessage(const char *message);
void displaySpectrum();

void checkMicrophoneLevel()
{
  int micValue = analogRead(MIC_PIN); // Lire la valeur brute du microphone
  Serial.printf("Niveau du micro : %d\n", micValue);
  delay(100); // Petite pause pour la lisibilité
}

void setup()
{
  analogSetAttenuation(ADC_11db);
  analogReadResolution(12);
  Serial.begin(115200);

  // Initialisation des LED
  parola.begin();
  parola.setIntensity(5);
  parola.displayClear();

  // Configuration WiFi
  WiFi.softAP(ssid, password);
  Serial.println("Point d'accès créé !");
  Serial.println(WiFi.softAPIP());

  // Routes HTTP
  server.on("/time", HTTP_POST, [](AsyncWebServerRequest *request)
            {
        if (request->hasParam("hour") && request->hasParam("minute"))
        {
            currentHour = request->getParam("hour")->value().toInt();
            currentMinute = request->getParam("minute")->value().toInt();
            isDisplayingSpectrum = false; // Arrêter le spectromètre si actif
            isDisplayingMessage = false; // Arrêter le message si actif
            displayTime();
            request->send(200, "text/plain", "Heure mise à jour !");
        }
        else
        {
            request->send(400, "text/plain", "Paramètres manquants !");
        } });

  server.on("/message", HTTP_POST, [](AsyncWebServerRequest *request)
            {
        if (request->hasParam("text"))
        {
            String message = request->getParam("text")->value();
            isDisplayingMessage = true;
            messageTimeout = millis() + 5000; // Afficher le message pendant 5 secondes
            isDisplayingSpectrum = false;    // Arrêter le spectromètre si actif
            displayMessage(message.c_str());
            request->send(200, "text/plain", "Message affiché !");
        }
        else
        {
            request->send(400, "text/plain", "Paramètre manquant !");
        } });

  server.on("/spectre", HTTP_POST, [](AsyncWebServerRequest *request)
            {
        isDisplayingSpectrum = true;
        spectrometerTimeout = millis() + 10000; // Afficher le spectre pendant 10 secondes
        request->send(200, "text/plain", "Spectromètre activé !"); });

  server.begin();
  displayTime(); // Affiche l’heure au démarrage
}

void loop()
{
  checkMicrophoneLevel();
  unsigned long now = millis();
  if (isDisplayingSpectrum)
  {
    displaySpectrum(); // Appel explicite pour afficher le spectromètre
    if (millis() > spectrometerTimeout)
    {
      isDisplayingSpectrum = false;
      displayTime(); // Retour à l'affichage de l'heure après le message
    }
  }
  else if (isDisplayingMessage)
  {
    if (parola.displayAnimate())
    {
      if (millis() > messageTimeout)
      {
        isDisplayingMessage = false;
        displayTime(); // Retour à l'affichage de l'heure après le message
      }
    }
  }
  else
  {
    if (parola.displayAnimate())
    {
      // Attendez 1 minute avant de rafraîchir l'heure
      if (now - lastTimeUpdate >= 60000)
      {
        lastTimeUpdate = now; // Réinitialisez l'horodatage
        displayTime();        // Affiche l'heure
      }
    }
  }
}

void displayTime()
{
  char buffer[6];
  sprintf(buffer, "%02d:%02d", currentHour, currentMinute);
  parola.displayClear();
  parola.displayText(buffer, PA_CENTER, 0, 0, PA_NO_EFFECT); // Affichage statique
  parola.displayAnimate();
}

void displayMessage(const char *message)
{
  parola.displayClear();
  parola.displayText(
      message,
      PA_CENTER,      // Alignement
      50,             // Vitesse
      2000,           // Pause
      PA_SCROLL_LEFT, // Effet d'entrée
      PA_SCROLL_LEFT  // Effet de sortie
  );
}
void displaySpectrum()
{
  Serial.println("Début de displaySpectrum");

  unsigned long sampleInterval = 1000000 / SAMPLING_FREQUENCY; // Intervalle en microsecondes
  unsigned long lastSampleTime = micros();

  // Capture des échantillons du microphone
  for (int i = 0; i < SAMPLES; i++)
  {
    while (micros() - lastSampleTime < sampleInterval)
      ;
    lastSampleTime = micros();
    vReal[i] = analogRead(MIC_PIN) * 5; // Amplification ajustée
    vImag[i] = 0.0;
  }

  // Effectuer la FFT sur les échantillons
  FFT.windowing(vReal, SAMPLES, FFT_WIN_TYP_HAMMING, FFT_FORWARD);
  FFT.compute(vReal, vImag, SAMPLES, FFT_FORWARD);
  FFT.complexToMagnitude(vReal, vImag, SAMPLES);

  // Appliquer un filtre passe-bas pour lisser les variations
  static double smoothedFFT[SAMPLES / 2] = {0};
  const double alpha = 0.3;
  for (int i = 0; i < SAMPLES / 2; i++)
  {
    smoothedFFT[i] = alpha * vReal[i] + (1 - alpha) * smoothedFFT[i];
    vReal[i] = smoothedFFT[i];
  }

  // Limiter les valeurs maximales dans la FFT
  for (int i = 0; i < SAMPLES / 2; i++)
  {
    vReal[i] = constrain(vReal[i], 0, 1000); // Limite maximale à 1000
  }

  // Initialisation de la chaîne d'affichage avec une taille calculée
  const size_t bufferSize = (MAX_DEVICES * 8) * (8 + 1) + 1; // Taille maximale
  char spectrumDisplay[bufferSize];
  spectrumDisplay[0] = '\0';

  // Seuil minimum pour afficher une bande
  const double amplitudeThreshold = 50.0;

  // Générer l'affichage du spectre
  for (int x = 0; x < MAX_DEVICES * 8; x++)
  {
    int startBin = x * (SAMPLES / 2) / (MAX_DEVICES * 8);
    int endBin = startBin + (SAMPLES / 2) / (MAX_DEVICES * 8);
    double amplitude = 0;

    for (int i = startBin; i < endBin; i++)
    {
      amplitude += vReal[i];
    }
    amplitude /= (endBin - startBin);

    // Appliquer un seuil minimum
    if (amplitude < amplitudeThreshold)
    {
      amplitude = 0;
    }

    // Mapper l'amplitude sur l'axe Y
    int barHeight = map(amplitude, 0, 1000, 0, 8);
    barHeight = constrain(barHeight, 0, 8);

    // Construire la colonne
    char column[9] = {'\0'};
    for (int y = 0; y < barHeight; y++)
    {
      column[y] = '|';
    }
    column[barHeight] = '\0';

    // Vérifier si l'espace restant est suffisant
    if (strlen(spectrumDisplay) + strlen(column) + 1 >= bufferSize)
    {
      Serial.println("Erreur : Dépassement de la taille du buffer détecté !");
      break;
    }
    strcat(spectrumDisplay, column);
    strcat(spectrumDisplay, " "); // Ajouter un espace entre colonnes
  }

  // Afficher le spectre généré
  Serial.println("Spectre généré :");
  Serial.println(spectrumDisplay);

  parola.displayClear();
  parola.displayText(spectrumDisplay, PA_CENTER, 50, 1000, PA_NO_EFFECT, PA_NO_EFFECT);
  parola.displayAnimate();
}
