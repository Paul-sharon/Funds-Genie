import 'package:flutter/material.dart';
import '../portfolio/portfolio.dart';
import '../screens/dashboard.dart';
import '../invest/invest.dart';
import 'SIPCalculator.dart';
import 'WealthCalculator.dart';
import 'package:flutter/services.dart';

class Morepage extends StatefulWidget {
  @override
  _MorepageState createState() => _MorepageState();
}
class _MorepageState extends State<Morepage> {
  int _selectedIndex = 3;

  void _onItemTapped(int index) {
    if (index == 0) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Dashboard()),
      );
    } else if (index == 1) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Portfolio()),
      );
    } else if (index == 2) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Invest()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Dark background
      appBar: AppBar(
        backgroundColor: const Color(0xFF2A2E34), // Black app bar background
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            // Set the navigation bar color before navigating
            SystemChrome.setSystemUIOverlayStyle(
              const SystemUiOverlayStyle(
                systemNavigationBarColor: Color(0xFF2A2E34), // Set to match your app theme
                systemNavigationBarIconBrightness: Brightness.light, // White icons
              ),
            );

            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Dashboard()),
            );
          },
        ),
        title: const Text(
          'More',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start, // Align at the top
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 20), // Add space at the top
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Color(0xFF2A2E34), // Card background
              borderRadius: BorderRadius.circular(15),
            ),
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Tools and Calculator',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildButton(
                      context,
                      icon: Icons.calculate, // Icon for SIP Calculator
                      label: '     SIP \n     Calculator',
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SIPCalculator()),
                        );
                      },
                    ),
                    _buildButton(
                      context,
                      icon: Icons.calculate_outlined,
                      // Icon for Wealth Calculator
                      label: '     Wealth \n     Calculator',
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => WealthCalculator()),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        backgroundColor: Color(0xFF2A2E34),
        selectedItemColor: Colors.greenAccent,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.dashboard), label: 'Dashboard'),
          BottomNavigationBarItem(
              icon: Icon(Icons.pie_chart), label: 'Portfolio'),
          BottomNavigationBarItem(
              icon: Icon(Icons.attach_money), label: 'Invest'),
          BottomNavigationBarItem(icon: Icon(Icons.more_horiz), label: 'More'),
        ],
      ),
    );
  }

  Widget _buildButton(BuildContext context,
      {required IconData icon, required String label, required VoidCallback onPressed}) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xFF2A2E34),
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8), // Rounded corners
          side: BorderSide(
            color: Color(0xFF4A4A45), // Border color
            width: 1.5, // Border width
          ),
        ),
      ),
      icon: Icon(
        icon,
        color: Colors.white,
        size: 25,
      ),
      label: Text(
        label,
        style: TextStyle(
          color: Colors.white, // Set text color
          fontSize: 16.0, // Specify the font size
        ),
      ),
    );
  }
}
