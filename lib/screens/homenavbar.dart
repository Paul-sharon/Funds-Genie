import 'package:flutter/material.dart';
import '../components/custom_app_bar.dart';
import 'ProfilePage.dart';
import 'dashboard.dart';
import '../invest/invest.dart';
import '../portfolio/portfolio.dart';
import '../More/Morepage.dart';

class Homenavbar extends StatefulWidget {
  final String username;
  final String email;      // Add email field
  final String phoneNumber; // Add phoneNumber field

  const Homenavbar({
    Key? key,
    required this.username,
    required this.email,      // Add email parameter to constructor
    required this.phoneNumber, // Add phoneNumber parameter to constructor
  }) : super(key: key);

  @override
  State<Homenavbar> createState() => _HomenavbarState();
}

class _HomenavbarState extends State<Homenavbar> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    Dashboard(),
    Portfolio(),
    Invest(),
    Morepage(),
  ];

  String getInitials(String name) {
    List<String> words = name.trim().split(" ");
    if (words.isEmpty) return "?";

    if (words.length == 1) {
      return words[0][0].toUpperCase(); // Single word, take the first letter
    } else {
      return "${words[0][0]}${words[1][0]}".toUpperCase(); // Take first letter of first and second word
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        username: widget.username,
        email: widget.email,       // Pass email to CustomAppBar
        phoneNumber: widget.phoneNumber, // Pass phoneNumber to CustomAppBar
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        backgroundColor: const Color(0xFF2A2E34),
        selectedItemColor: Colors.greenAccent,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.pie_chart),
            label: 'Portfolio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.attach_money),
            label: 'Invest',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.more_horiz),
            label: 'More',
          ),
        ],
      ),
    );
  }
}
