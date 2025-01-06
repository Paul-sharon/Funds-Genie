import 'package:flutter/material.dart';
import 'screens/loginpage.dart';
import 'screens/registerpage.dart';
void main() => runApp(MutualFundApp());

class MutualFundApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        primaryColor: Color(0xFF0A0E21),
        scaffoldBackgroundColor: Color(0xFF0A0E21),
      ),
      home: LoginPage(), // Set LoginPage as the home
    );
  }
}