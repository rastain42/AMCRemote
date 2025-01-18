import 'package:flutter/material.dart';
import 'time_page.dart';
import 'message_page.dart';
import 'spectrometer_page.dart';

class HomePage extends StatefulWidget {
  final String baseUrl;

  const HomePage({Key? key, required this.baseUrl}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      TimePage(baseUrl: widget.baseUrl),
      MessagePage(baseUrl: widget.baseUrl),
      SpectrometerPage(baseUrl: widget.baseUrl),
    ];

    return Scaffold(
      appBar: AppBar(title: Text("LED Matrix Remote")),
      body: pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.access_time), label: "Heure"),
          BottomNavigationBarItem(icon: Icon(Icons.message), label: "Message"),
          BottomNavigationBarItem(icon: Icon(Icons.mic), label: "Spectromètre"),
        ],
      ),
    );
  }
}
