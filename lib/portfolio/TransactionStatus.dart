import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Transaction Status',
      home: TransactionStatusScreen(),
    );
  }
}

class TransactionStatusScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Dark background color
      body: Center(
        child: Container(
          width: 360,
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.grey[900], // Dark container background
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min, // Make container height minimal
            children: [
              Text(
                'Transaction Status',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16.0), // Space between title and status items
              _buildStatusTile(
                icon: Icons.check_circle,
                iconColor: Colors.green,
                title: 'Order placed with BSE',
                date: '22 Nov 2024',
              ),
              _buildStatusTile(
                icon: Icons.access_time,
                iconColor: Colors.yellow,
                title: 'Payment Received',
              ),
              _buildStatusTile(
                icon: Icons.check_circle,
                iconColor: Colors.green,
                title: 'Order accepted by RTA',
                date: '22 Nov 2024',
              ),
              _buildStatusTile(
                icon: Icons.check_circle,
                iconColor: Colors.green,
                title: 'Portfolio updation',
                date: '22 Nov 2024',
                showLine: false, // No line after this item
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusTile({
    required IconData icon,
    required Color iconColor,
    required String title,
    String? date,
    bool showLine = true, // New parameter to control line visibility
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Column(
            children: [
              Icon(icon, color: iconColor),
              if (showLine)
                SizedBox(
                  height: 25.0,
                  width: 2.0,
                  child: Container(
                    color: iconColor,
                  ),
                ),
            ],
          ),
          SizedBox(width: 16.0),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: TextStyle(color: Colors.white, fontSize: 16.0),
                ),
                if (date != null)
                  Text(
                    date,
                    style: TextStyle(color: Colors.grey),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
