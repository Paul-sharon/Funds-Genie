import 'package:flutter/material.dart';
import 'dashboard.dart';
import '../invest/invest.dart';
import '../portfolio/portfolio.dart';
import '../More/Morepage.dart';

class Homenavbar extends StatefulWidget {
  const Homenavbar({Key? key}) : super(key: key);

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFF2A2E34),
        title: Row(
          children: [
            const CircleAvatar(
              backgroundImage: AssetImage('assets/paul.jpg'),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Welcome,',
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
                Text(
                  'SHARON',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const Spacer(),
            const Icon(Icons.search_rounded, color: Colors.white, size: 36.0),
          ],
        ),
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
