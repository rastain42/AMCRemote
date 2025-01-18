# Afficheur multi contenu

cet afficheur est composé

- d'une appli flutter
- d'un montage avec : un esp32, une matrice d'affichage led, un microphone, et un capteur de température et d'humidité

![Schéma de montage](./schéma%20cablage.png "Schéma de montage").

## fonctionnement

l'utilisateur lance l'appli sur son mobile, se connecte au hotspot wifi crée par l'esp, ici le nom du réseau "ESP32_Matrix" et le mot de passe "12345678";  
il peut donc naviguer entre les différents menus et déclencher les fonctionnalités :

- affichage de l'heure
- affichage d'un texte défilant
- affichage d'un volume sonore

## améliorations possibles

suite a un désaccord parmi les personnes du projet et un parti pris evident de l'enseignant  
voici les améliorations qui seront réalisées a l'avenir :

- pouvoir modifier le mot de passe par défaut du hotspot de l'esp via l'application
- pouvoir connecter plusieurs afficheurs led grace a un serveur MQTT hebergé sur un ESP32
