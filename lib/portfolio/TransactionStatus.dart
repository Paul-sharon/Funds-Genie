import 'package:flutter/material.dart';
import 'package:mutualfund_gtl/portfolio/TransactionCompleted.dart';

class TransactionStatus extends StatelessWidget {
  const TransactionStatus({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Transaction Status',
      home: const CombinedScreen(),
    );
  }
}

class CombinedScreen extends StatelessWidget {
  const CombinedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF2A2E34), // Black app bar background
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => TransactionCompleted()),
            );
          },
        ),
        title: const Text(
          'Order Details',
          style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold), // White text for title
        ),
      ),
      backgroundColor: Colors.black, // Black background for the screen
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: const [
              FundCard(), // FundCard widget
              SizedBox(height: 16.0), // Space between FundCard and TransactionStatusScreen
              TransactionStatusScreen(), // TransactionStatusScreen widget
            ],
          ),
        ),
      ),
    );
  }
}

// -------------------- FundCard Component --------------------
class FundCard extends StatelessWidget {
  const FundCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.house, size: 40, color: Colors.cyan),
                const SizedBox(width: 10),
                Expanded(
                  child: const Text(
                    'Aditya Birla Sun Life Flexi Cap Fund - IDCW-Regular P...',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 10),
                const Text(
                  '₹9.98',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Order No Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  'Order No: 558490955',
                  style: TextStyle(fontSize: 14, color: Colors.grey,fontWeight: FontWeight.bold),
                ),
                Icon(Icons.circle, size: 10, color: Colors.green),
              ],
            ),
            const SizedBox(height: 16),

            // Units, NAV, NAV Date Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Units
                _infoColumn('Units', '0.064'),
                // NAV
                _infoColumn('NAV', '155.48'),
                // NAV Date
                _infoColumn('NAV Date', '2 Dec 2024'),
              ],
            ),
            const SizedBox(height: 16),

            // Footer Section
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.all(8.0),
              child: const Text(
                'FOLIO NO: 1043916062',
                style: TextStyle(fontSize: 14, color: Colors.black),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper method for consistent information display
  static Widget _infoColumn(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 14, color: Colors.grey),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}

// -------------------- TransactionStatusScreen Component --------------------
class TransactionStatusScreen extends StatelessWidget {
  const TransactionStatusScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Color(0xFF2A2E34), // Dark container background
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Transaction Status',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16.0), // Space between title and status items
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
    );
  }

  // Helper method to create status tiles
  static Widget _buildStatusTile({
    required IconData icon,
    required Color iconColor,
    required String title,
    String? date,
    bool showLine = true,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Column(
            children: [
              Icon(icon, color: iconColor),
              if (showLine)
                Container(
                  height: 25.0,
                  width: 2.0,
                  color: iconColor,
                ),
            ],
          ),
          const SizedBox(width: 16.0),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(color: Colors.white, fontSize: 16.0),
                ),
                if (date != null)
                  Text(
                    date,
                    style: const TextStyle(color: Colors.grey),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
