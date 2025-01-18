import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MessagePage extends StatefulWidget {
  final String baseUrl;

  const MessagePage({Key? key, required this.baseUrl}) : super(key: key);

  @override
  _MessagePageState createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  final TextEditingController _messageController = TextEditingController();
  String _statusMessage = "";

  Future<void> sendMessage() async {
    final message = _messageController.text.trim();
    if (message.isEmpty) {
      setState(() {
        _statusMessage = "Le message ne peut pas être vide.";
      });
      return;
    }

    final url = Uri.parse('${widget.baseUrl}/message?text=$message');

    try {
      final response = await http.post(url);
      if (response.statusCode == 200) {
        setState(() {
          _statusMessage = "Message envoyé avec succès !";
        });
      } else {
        setState(() {
          _statusMessage = "Erreur HTTP : ${response.statusCode} - ${response.body}";
        });
      }
    } catch (e) {
      setState(() {
        _statusMessage = "Erreur de connexion à l'ESP32 : $e";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Envoyer un message'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _messageController,
              decoration: InputDecoration(
                labelText: "Message",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: sendMessage,
              child: Text("Envoyer"),
            ),
            SizedBox(height: 20),
            Text(
              _statusMessage,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.red),
            ),
          ],
        ),
      ),
    );
  }
}
