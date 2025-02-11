import 'package:flutter/material.dart';

class TransactionStatus extends StatelessWidget {
  final List<Map<String, dynamic>> transactions;

  const TransactionStatus({Key? key, required this.transactions})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF2A2E34),
        title: const Text(
          'Transaction Status',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: transactions.isEmpty
          ? const Center(
        child: Text(
          'No Transactions Available',
          style: TextStyle(fontSize: 16, color: Colors.black),
        ),
      )
          : ListView.builder(
        itemCount: transactions.length,
        itemBuilder: (context, index) {
          final transaction = transactions[index];
          return Card(
            margin: const EdgeInsets.symmetric(
                horizontal: 16.0, vertical: 8.0),
            child: ListTile(
              leading: const Icon(
                Icons.attach_money,
                color: Colors.teal,
                size: 40,
              ),
              title: Text(
                transaction['companyName'] ?? 'Unknown Company',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Date: ${transaction['investDate'] ?? 'Unknown Date'}',
                    style: const TextStyle(fontSize: 14),
                  ),
                  Text(
                    'Units: ${transaction['units']?.toString() ?? '0.000'} Unit',
                    style: const TextStyle(fontSize: 14),
                  ),
                  Text(
                    'Status: ${transaction['transactionStatus'] ?? 'Unknown'}',
                    style: const TextStyle(
                      color: Colors.blueGrey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
