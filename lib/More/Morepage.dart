import 'package:flutter/material.dart';
import 'SIPCalculator.dart';
import 'WealthCalculator.dart';


class Morepage extends StatefulWidget {
  @override
  _MorepageState createState() => _MorepageState();
}

class _MorepageState extends State<Morepage> {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 50), // Space at the top
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
                                MaterialPageRoute(builder: (context) => Sipcalculator()),
                              );
                            },
                          ),
                          _buildButton(
                            context,
                            icon: Icons.calculate_outlined,
                            label: '     Wealth \n     Calculator',
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => Wealthcalculator()),
                              );
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: 16), // Space before logout button
                      // Align(
                      //   alignment: Alignment.centerRight,
                      //   child: ElevatedButton(
                      //     onPressed: () {
                      //       _logout(); // Call the void function without expecting a value
                      //     },
                      //     style: ElevatedButton.styleFrom(
                      //       backgroundColor: Color(0xFFf44336), // Red color for the logout button
                      //       padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      //       shape: RoundedRectangleBorder(
                      //         borderRadius: BorderRadius.circular(8),
                      //       ),
                      //     ),
                      //     child: Text(
                      //       'Logout',
                      //       style: TextStyle(color: Colors.white),
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
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
