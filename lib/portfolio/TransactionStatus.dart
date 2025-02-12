import 'dart:convert';
import 'package:flutter/material.dart';

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
        backgroundColor: const Color(0xFF2A2E34),
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
          padding: const EdgeInsets.symmetric(horizontal: 3,vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      spreadRadius: 2,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        (transaction['companyImg']?.isNotEmpty ?? false)
                            ? ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.memory(
                            base64Decode(transaction['companyImg']!),
                            width: 40,
                            height: 40,
                            fit: BoxFit.cover,
                          ),
                        )
                            : const Icon(Icons.business, size: 40, color: Colors.cyan),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            transaction['companyName'] ?? 'Unknown Fund',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            softWrap: true,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Text(
                          'Order No: ${transaction['orderNo'] ?? 'N/A'}',
                          style: const TextStyle(
                            fontSize: 16,

                            color: Colors.black,
                          ),
                        ),
                        SizedBox(width: 10),
                        const Icon(Icons.circle, size: 10, color: Colors.green),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _infoColumn('Units', '${double.tryParse(transaction['units']?.toString() ?? '0')?.toStringAsFixed(3) ?? '0.000'}'),
                        _infoColumn('NAV', transaction['navRate']?.toString() ?? '0.00'),
                        _infoColumn('NAV Date', transaction['investDate'] ?? 'N/A'),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        'FOLIO NO: ${transaction['folioNo'] ?? 'N/A'}',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 10.0),

              // ✅ Transaction Status Section Wrapped in Container
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: const Color(0xFF2A2E34),
                  borderRadius: BorderRadius.circular(10.0),
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
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Widget _infoColumn(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,

            color: Colors.black,
          ),
        ),
      ],
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
