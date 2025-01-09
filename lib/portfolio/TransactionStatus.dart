import 'package:flutter/material.dart';
class TransactionStatus extends StatelessWidget {
  const TransactionStatus({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF2A2E34),
        title: const Text(
          'Transaction Status',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: const Center(
        child: Text(
          'Details of Transaction Status',
          style: TextStyle(fontSize: 16, color: Colors.black),
        ),
      ),
    );
  }
}