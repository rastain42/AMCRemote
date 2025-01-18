import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TimePage extends StatelessWidget {
  final String baseUrl;

  const TimePage({Key? key, required this.baseUrl}) : super(key: key);

  Future<void> updateTime() async {
    final now = DateTime.now();
    final url = Uri.parse('$baseUrl/time?hour=${now.hour}&minute=${now.minute}');

    try {
      final response = await http.post(url);
      if (response.statusCode == 200) {
        print("Heure mise à jour avec succès !");
      } else {
        print("Erreur HTTP : ${response.statusCode}");
      }
    } catch (e) {
      print("Erreur de connexion : $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: updateTime,
        child: Text("Envoyer l'heure actuelle"),
      ),
    );
  }
}
