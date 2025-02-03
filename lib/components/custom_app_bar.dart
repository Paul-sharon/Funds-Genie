import 'package:flutter/material.dart';
import '../screens/ProfilePage.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String username;
  final String email;
  final String phoneNumber;

  const CustomAppBar({
    Key? key,
    required this.username,
    required this.email,
    required this.phoneNumber,
  }) : super(key: key);

  String getInitials(String name) {
    List<String> words = name.trim().split(" ");
    if (words.isEmpty) return "?";
    return words.length == 1
        ? words[0][0].toUpperCase()
        : "${words[0][0]}${words[1][0]}".toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: true, // Show back button on Profile Page
      backgroundColor: const Color(0xFF2A2E34),
      title: Row(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfilePage(
                    username: username,
                    email: email,
                    phoneNumber: phoneNumber,
                  ),
                ),
              );
            },
            child: CircleAvatar(
              backgroundColor: Colors.teal,
              child: Text(
                getInitials(username),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Welcome,',
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
              Text(
                username.toUpperCase(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const Spacer(),
          const Icon(Icons.search_rounded, color: Colors.white, size: 36.0),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}