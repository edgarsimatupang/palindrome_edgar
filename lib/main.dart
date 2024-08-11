import 'package:flutter/material.dart';
import 'screens/first_screen.dart';
import 'screens/second_screen.dart';
import 'screens/third_screen.dart';

void main() {
  runApp(PalindromeApp());
}

class PalindromeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Palindrome App',
      initialRoute: '/',
      routes: {
        '/': (context) => FirstScreen(),
        '/second': (context) => SecondScreen(),
        '/third': (context) => ThirdScreen(),
      },
    );
  }
}
