import 'package:flutter/material.dart';
import '../components/custom_app_bar.dart';
import 'dashboard.dart';
import '../invest/invest.dart';
import '../portfolio/portfolio.dart';
import '../More/Morepage.dart';

class Homenavbar extends StatefulWidget {
  final String username;
  final String email;
  final String phoneNumber;

  const Homenavbar({
    Key? key,
    required this.username,
    required this.email,
    required this.phoneNumber,
  }) : super(key: key);

  @override
  State<Homenavbar> createState() => _HomenavbarState();
}

class _HomenavbarState extends State<Homenavbar> {
  int _currentIndex = 0;

  String getInitials(String name) {
    List<String> words = name.trim().split(" ");
    if (words.isEmpty) return "?";
    return words.length == 1
        ? words[0][0].toUpperCase()
        : "${words[0][0]}${words[1][0]}".toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    // Move _pages inside build to access widget properties
    final List<Widget> _pages = [
      Dashboard(
        username: widget.username,
        email: widget.email,
        phoneNumber: widget.phoneNumber,
      ),
      Portfolio(),
      Invest(),
      Morepage(),
    ];

    return Scaffold(
      appBar: CustomAppBar(
        username: widget.username,
        email: widget.email,
        phoneNumber: widget.phoneNumber,
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
