import 'package:flutter/material.dart';
class Portfolio extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Portfolio'),
        backgroundColor: Color(0xFF2A2E34),
      ),
      body: Center(
        child: Text(
          'Welcome to Portfolio Page!',
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
      backgroundColor: Colors.black,
    );
  }
}