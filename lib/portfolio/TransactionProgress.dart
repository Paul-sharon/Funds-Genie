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
  List<Map<String, dynamic>> completedTransactions = [];
  List<Map<String, dynamic>> inProgressTransactions = [];
  List<Map<String, dynamic>> failedTransactions = [];
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
          completedTransactions = fetchedTransactions
              .where((tx) => tx['transactionStatus']?.toString().toLowerCase() == 'completed')
              .toList();
          inProgressTransactions = fetchedTransactions
              .where((tx) => tx['transactionStatus']?.toString().toLowerCase() == 'in progress')
              .toList();
          failedTransactions = fetchedTransactions
              .where((tx) => tx['transactionStatus']?.toString().toLowerCase() == 'failed')
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
      initialIndex: 1, // Default to "In Progress"
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
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            indicator: UnderlineTabIndicator(
              borderSide: BorderSide(
                color: Colors.teal,
                width: 5.0,
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
            ? const Center(child: CircularProgressIndicator())
            : TabBarView(
          children: [
            TransactionsTab(transactions: completedTransactions),
            TransactionsTab(transactions: inProgressTransactions),
            TransactionsTab(transactions: failedTransactions),
          ],
        ),
      ),
    );
  }
}

class TransactionsTab extends StatelessWidget {
  final List<Map<String, dynamic>> transactions;

  const TransactionsTab({Key? key, required this.transactions}) : super(key: key);

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

    final Map<String, List<Map<String, dynamic>>> groupedTransactions = {};
    for (var transaction in transactions) {
      String monthYear = formatMonthYear(transaction['investDate']?.toString() ?? '');
      groupedTransactions.putIfAbsent(monthYear, () => []);
      groupedTransactions[monthYear]!.add(transaction);
    }

    return ListView.builder(
      itemCount: groupedTransactions.length,
      itemBuilder: (context, index) {
        String monthYear = groupedTransactions.keys.elementAt(index);
        List<Map<String, dynamic>> monthTransactions = groupedTransactions[monthYear]!;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              child: Text(
                monthYear,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
            ...monthTransactions.asMap().entries.map((entry) {
              return TransactionCard(
                date: formatDate(entry.value['investDate']?.toString() ?? 'Unknown Date'),
                fundName: entry.value['companyName']?.toString() ?? 'Unknown Fund',
                units: entry.value['units']?.toString() ?? '0.000 Unit',
                tag: entry.value['tag']?.toString(),
                companyImgBase64: entry.value['companyImg']?.toString(),
                transactions: transactions,
                selectedIndex: entry.key,
              );
            }).toList(),
          ],
        );
      },
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
  final int selectedIndex;

  const TransactionCard({
    Key? key,
    required this.date,
    required this.fundName,
    required this.units,
    this.tag,
    this.companyImgBase64,
    required this.transactions,
    required this.selectedIndex,
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
                  TransactionStatus(transactions: transactions, selectedIndex: selectedIndex),
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
      return Image.memory(base64Decode(companyImgBase64!), width: 50, height: 50, fit: BoxFit.cover);
    } catch (e) {
      return const Icon(Icons.error, size: 40, color: Colors.red);
    }
  }
}
