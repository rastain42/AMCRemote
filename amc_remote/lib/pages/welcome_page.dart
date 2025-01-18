import 'package:flutter/material.dart';

class WelcomePage extends StatefulWidget {
  final Function(String) onConnected;

  const WelcomePage({super.key, required this.onConnected});

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  final TextEditingController _ssidController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isConnecting = false;
  String _statusMessage = "Entrez les détails pour vous connecter à l'ESP32.";

  Future<void> _connectToESP32() async {
    setState(() {
      _isConnecting = true;
      _statusMessage = "Connexion en cours...";
    });

    // Simuler une vérification réseau (ici, par défaut on accepte)
    await Future.delayed(const Duration(seconds: 3));
    setState(() {
      _isConnecting = false;
      _statusMessage = "Connexion réussie !";
    });

    // Appeler le callback pour passer à la navbar
    widget.onConnected("http://192.168.4.1"); // Adresse IP de l'ESP32
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Connectez votre téléphone au réseau de l'esp32")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Nom du réseau(SSID): ESP32_Matrix"),
            const SizedBox(height: 10),
            const Text("Mot de passe par défaut : '12345678'"),
            const SizedBox(height: 10),
            const Text(
                "n'oubliez pas de désactiver vos données mobiles,\nvous enverrez pas la requète sur le bon réseau"),
            const SizedBox(height: 20),
            _isConnecting
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: _connectToESP32,
                    child: const Text("Je suis connecté"),
                  ),
            const SizedBox(height: 20),
            Text(
              _statusMessage,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
