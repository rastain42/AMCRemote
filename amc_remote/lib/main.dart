import 'package:amc_remote/pages/home_page.dart';
import 'package:amc_remote/pages/welcome_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String? _baseUrl = 'http://192.168.4.1';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ESP32 Remote',
      home: _baseUrl == null
          ? WelcomePage(onConnected: (baseUrl) {
              setState(() {
                _baseUrl = baseUrl;
              });
            })
          : HomePage(baseUrl: _baseUrl!),
    );
  }
}
