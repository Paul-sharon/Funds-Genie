import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TransactionStatus extends StatelessWidget {
  final List<Map<String, dynamic>> transactions;
  final int selectedIndex;

  const TransactionStatus({
    Key? key,
    required this.transactions,
    required this.selectedIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Ensure selectedIndex is within range
    if (selectedIndex < 0 || selectedIndex >= transactions.length) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF2A2E34),
          title: const Text(
            'Transaction Status',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
          ),
        ),
        body: const Center(
          child: Text(
            'Invalid Transaction Selected',
            style: TextStyle(fontSize: 16, color: Colors.red),
          ),
        ),
      );
    }

    final transaction = transactions[selectedIndex];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF2A2E34), // Dark app bar
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Order Details',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      backgroundColor: Colors.black, // Dark background
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              FundCard(transaction: transaction), // FundCard with data binding
              const SizedBox(height: 16.0),
              TransactionStatusScreen(transaction: transaction), // Status section
            ],
          ),
        ),
      ),
    );
  }
}


class FundCard extends StatelessWidget {
  final Map<String, dynamic> transaction;

  const FundCard({Key? key, required this.transaction}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
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
                transaction['companyImg'] != null
                    ? ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.memory(
                    base64Decode(transaction['companyImg']!),
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                )
                    : const Icon(Icons.business, size: 40, color: Colors.cyan), // Default icon
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    transaction['companyName'] ?? 'Unknown Fund',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2, // Allow up to 2 lines
                    overflow: TextOverflow.ellipsis, // Add "..." if text is too long
                    softWrap: true, // Enable text wrapping
                  ),
                ),
                const SizedBox(width: 10),
                // Text(
                //   '₹${transaction['nav']?.toString() ?? '0.00'}',
                //   style: const TextStyle(
                //     fontSize: 16,
                //     fontWeight: FontWeight.bold,
                //     color: Colors.white,
                //   ),
                // ),
              ],
            ),
            const SizedBox(height: 16),

            // Order No Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Order No: ${transaction['orderNo'] ?? 'N/A'}',
                  style: const TextStyle(fontSize: 14, color: Colors.grey, fontWeight: FontWeight.bold),
                ),
                const Icon(Icons.circle, size: 10, color: Colors.green),
              ],
            ),
            const SizedBox(height: 16),

            // Units, NAV, NAV Date Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _infoColumn('Units', '${double.tryParse(transaction['units']?.toString() ?? '0')?.toStringAsFixed(3) ?? '0.000'}'),
                _infoColumn('NAV', transaction['navRate']?.toString() ?? '0.00'),
                _infoColumn('NAV Date', transaction['investDate'] ?? 'N/A'),
              ],
            ),
            const SizedBox(height: 16),

            // Folio Number
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'FOLIO NO: ${transaction['folioNo'] ?? 'N/A'}',
                style: const TextStyle(fontSize: 14, color: Colors.black),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget _infoColumn(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 14, color: Colors.grey)),
        const SizedBox(height: 4),
        Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      ],
    );
  }
}

class TransactionStatusScreen extends StatelessWidget {
  final Map<String, dynamic> transaction;

  const TransactionStatusScreen({Key? key, required this.transaction}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2E34),
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
          const SizedBox(height: 16.0),
          _buildStatusTile(
            icon: Icons.check_circle,
            iconColor: Colors.green,
            title: 'Order placed with BSE',
            date: transaction['investDate'] ?? 'N/A',
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
            date: transaction['investDate'] ?? 'N/A',
          ),
          _buildStatusTile(
            icon: Icons.check_circle,
            iconColor: Colors.green,
            title: 'Portfolio updation',
            date: transaction['investDate'] ?? 'N/A',
            showLine: false,
          ),
        ],
      ),
    );
  }

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
                Container(height: 25.0, width: 2.0, color: iconColor),
            ],
          ),
          const SizedBox(width: 16.0),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title, style: const TextStyle(color: Colors.white, fontSize: 16.0)),
                if (date != null)
                  Text(date, style: const TextStyle(color: Colors.grey)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
