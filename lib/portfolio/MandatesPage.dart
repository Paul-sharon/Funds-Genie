import 'package:flutter/material.dart';

class MandatesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mandates"),
        backgroundColor: Color(0xFF2A2E34), // Matching the theme color
      ),
      body: Center(
        child: Text(
          "Welcome to the Mandates Page!",
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
      backgroundColor: Colors.black, // Background color for consistency
    );
  }
}
