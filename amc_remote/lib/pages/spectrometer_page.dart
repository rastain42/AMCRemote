import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SpectrometerPage extends StatefulWidget {
  const SpectrometerPage({super.key, required this.baseUrl});
  final String baseUrl;

  @override
  _SpectrometerPageState createState() => _SpectrometerPageState();
}

class _SpectrometerPageState extends State<SpectrometerPage> {
  void _startSpectre() async {
    final url = Uri.parse('${widget.baseUrl}/spectre');
    try {
      final response = await http.post(url);
      if (response.statusCode == 200) {
        print("spectre mise à jour avec succès !");
      } else {
        print("Erreur HTTP : ${response.statusCode}");
      }
    } catch (e) {
      print("Erreur de connexion : $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Spectromètre'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: _startSpectre,
            child: Text('Démarrer'),
          ),
        ],
      ),
    );
  }
}
