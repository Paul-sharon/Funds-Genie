import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../services/api_service.dart';
import 'TransactionCompleted.dart';
import 'TransactionFailed.dart';
import 'TransactionStatus.dart';

class TransactionProgress extends StatefulWidget {
  const TransactionProgress({Key? key}) : super(key: key);

  @override
  _TransactionProgressState createState() => _TransactionProgressState();
}

class _TransactionProgressState extends State<TransactionProgress> {
  List<Map<String, dynamic>> transactions = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchTransactions();
  }

  Future<void> fetchTransactions() async {
    try {
      final fetchedTransactions = await ApiService.getTransactions();

      if (mounted) {
        setState(() {
          transactions = fetchedTransactions
              .where((tx) =>
          tx['transactionStatus']?.toString().toLowerCase() ==
              'in progress')
              .toList();
          isLoading = false;
        });
      }
    } catch (e) {
      print("Error fetching transactions: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      initialIndex: 1, // Set default tab to "In Progress"
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: const Color(0xFF2A2E34),
          title: const Text(
            'Transaction Details',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
          bottom: const TabBar(
            labelColor: Colors.white, // Active tab text color
            unselectedLabelColor: Colors.white70, // Inactive tab text color
            indicator: UnderlineTabIndicator(
              borderSide: BorderSide(
                color: Colors.teal, // Indicator color
                width: 5.0, // Thickness of the indicator
              ),
              insets: EdgeInsets.fromLTRB(75.0, 0.0, 80.0, 0.0),
            ),
            tabs: [
              Tab(text: 'Completed'),
              Tab(text: 'In Progress'),
              Tab(text: 'Failed'),
            ],
          ),
        ),
        body: isLoading
            ? const Center(child: CircularProgressIndicator()) // Loading spinner
            : TabBarView(
          children: [
            const TransactionCompleted(),
            ProgressTransactionsTab(transactions: transactions),
            const TransactionFailed(),
          ],
        ),
      ),
    );
  }
}

class ProgressTransactionsTab extends StatelessWidget {
  final List<Map<String, dynamic>> transactions;

  const ProgressTransactionsTab({Key? key, required this.transactions})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (transactions.isEmpty) {
      return const Center(
        child: Text(
          "No Transactions found.",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.blueGrey,
          ),
        ),
      );
    }

    // Extract the formatted month-year from the first transaction date
    String monthYear = transactions.isNotEmpty
        ? formatMonthYear(transactions.last['investDate']?.toString() ?? '')
        : 'No Transactions';

    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            monthYear,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.black,
            ),
          ),
        ),
        ...transactions.map((transaction) => TransactionCard(
          date: formatDate(transaction['investDate']?.toString() ?? 'Unknown Date'),
          fundName: transaction['companyName']?.toString() ?? 'Unknown Fund',
          units: transaction['units']?.toString() ?? '0.000 Unit',
          tag: transaction['tag']?.toString(),
          companyImgBase64: transaction['companyImg']?.toString(), // Base64 Image Handling
          transactions: transactions, // Pass the transactions list
        )),
      ],
    );
  }

  String formatDate(String dateString) {
    try {
      DateTime parsedDate = DateTime.parse(dateString);
      return DateFormat('dd MMM yyyy').format(parsedDate);
    } catch (e) {
      return 'Invalid Date';
    }
  }

  String formatMonthYear(String dateString) {
    try {
      DateTime parsedDate = DateTime.parse(dateString);
      return DateFormat('MMMM yyyy').format(parsedDate).toUpperCase();
    } catch (e) {
      return 'Invalid Date';
    }
  }
}

class TransactionCard extends StatelessWidget {
  final String date;
  final String fundName;
  final String units;
  final String? tag;
  final String? companyImgBase64;
  final List<Map<String, dynamic>> transactions;

  const TransactionCard({
    Key? key,
    required this.date,
    required this.fundName,
    required this.units,
    this.tag,
    this.companyImgBase64,
    required this.transactions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: ListTile(
        leading: _buildImage(),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  TransactionStatus(transactions: transactions),
            ),
          );
        },
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              date,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black,
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios_sharp,
              color: Colors.black54,
              size: 20.0,
            ),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 9),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    fundName,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                ),
                Text(
                  '${double.tryParse(units)?.toStringAsFixed(3) ?? '0.000'} Unit',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            if (tag != null)
              Container(
                margin: const EdgeInsets.only(top: 8),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.teal.shade100,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  tag!,
                  style: const TextStyle(
                    color: Colors.teal,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            const SizedBox(height: 18),
          ],
        ),
      ),
    );
  }

  Widget _buildImage() {
    if (companyImgBase64 == null || companyImgBase64!.isEmpty) {
      return const Icon(Icons.business, size: 40, color: Colors.grey);
    }
    try {
      final bytes = base64Decode(companyImgBase64!);
      return ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.memory(
          bytes,
          width: 50,
          height: 50,
          fit: BoxFit.cover,
        ),
      );
    } catch (e) {
      print("Error decoding Base64 image: $e");
      return const Icon(Icons.error, size: 40, color: Colors.red);
    }
  }
}
