import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  final String username;

  const ProfilePage({Key? key, required this.username}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("$username's Profile"),
        backgroundColor: Colors.teal,
      ),
      body: Center(
        child: Text(
          "Welcome to $username's Profile Page!",
          style: const TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
