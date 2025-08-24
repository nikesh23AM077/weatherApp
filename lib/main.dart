import 'package:flutter/material.dart';
import 'package:weather_app_flu/weatherScreen.dart';

void main() {
  runApp(const weatherApp());
}

class weatherApp extends StatefulWidget {
  const weatherApp({super.key});

  @override
  State<weatherApp> createState() => _weatherAppState();
}

class _weatherAppState extends State<weatherApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      // color: Color.fromARGB(255, 44, 41, 50),
      home: weatherScreen(),
    );
  }
}
