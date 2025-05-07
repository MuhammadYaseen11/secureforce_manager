import 'package:flutter/material.dart';
import 'screens/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SecureForce Manager',
      theme: ThemeData(primaryColor: const Color.fromARGB(255, 176, 70, 63)),
      home: const MyHomePage(),
    );
  }
}
