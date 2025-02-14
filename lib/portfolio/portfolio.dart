import 'package:flutter/material.dart';
import 'package:mutualfund_gtl/portfolio/TransactionProgress.dart';
import 'package:mutualfund_gtl/services/api_service.dart'; // Import API service
import 'package:intl/intl.dart';
import 'TransactionStatus.dart';
import 'package:lottie/lottie.dart';

class Portfolio extends StatefulWidget {
  @override
  _PortfolioState createState() => _PortfolioState();
}

class _PortfolioState extends State<Portfolio> {
  List<Map<String, dynamic>> completedTransactions = [];
  List<Map<String, dynamic>> inProgressTransactions = [];
  List<Map<String, dynamic>> failedTransactions = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchTransactions(); // Call API on widget initialization
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
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 14),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(25.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade300,
                blurRadius: 8.0,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: const [
                    Text(
                      "Transaction Summary  ",
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    Text(
                      "(Last 30 days)",
                      style: TextStyle(
                        fontSize: 15.0,
                        color: Colors.black87,
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 10),
                isLoading
                    ? Center(child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 200),
                    Lottie.asset("assets/Animation.json", width: 180,height: 180), // Download a Lottie JSON animation
                    SizedBox(height: 250),
                    Text(
                      "Loading transactions...",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blueGrey),
                    ),
                  ],
                ),) // Show loader while fetching data
                    : Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 30.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          flex: 1,
                          child: _buildSummaryCard(
                            completedTransactions.length.toString(),
                            "Completed",
                            Colors.green.shade100,
                            Colors.green.shade700,
                            0,  // Pass index 0 for Completed
                          ),
                        ),
                        Flexible(
                          flex: 1,
                          child: _buildSummaryCard(
                            inProgressTransactions.length.toString(),
                            "In Progress",
                            Colors.orange.shade100,
                            Colors.orange,
                            1,  // Pass index 1 for In Progress
                          ),
                        ),
                        Flexible(
                          flex: 1,
                          child: _buildSummaryCard(
                            failedTransactions.length.toString(),
                            "Failed",
                            Colors.red.shade100,
                            Colors.redAccent,
                            2,  // Pass index 2 for Failed
                          ),
                        ),
                      ],
                    ),

                    Container(
                      color: Colors.red, // Debug color
                      child: const SizedBox(height: 2.0),
                    ),
                  ],
                ),
                isLoading
                    ? SizedBox()
                    : ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: inProgressTransactions.length >= 3
                      ? 3
                      : inProgressTransactions.length,
                  itemBuilder: (context, index) {
                    final reversedTransactions = inProgressTransactions.reversed.toList();
                    final transaction = reversedTransactions[index];

                    return _buildTransactionItem(
                      date: formatDate(transaction['investDate']?.toString() ?? 'Unknown Date'),
                      status: (transaction['transactionStatus']?.toString() ?? 'N/A').toUpperCase(),
                      type: transaction['type'] ?? 'LUMPSUM',
                      fundName: transaction['companyName'] ?? 'N/A',
                      amount: "₹${NumberFormat('#,##0', 'en_IN').format((transaction['amount'] ?? 0).toInt())}",
                      selectedIndex: index,
                      transactions: reversedTransactions, // Pass transactions list
                    );
                  },
                ),


                Center(
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => TransactionProgress()),
                      );
                    },
                    child: const Text(
                      "View more →",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
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
  Widget _buildSummaryCard(String value, String title, Color backgroundColor, Color textColor, int tabIndex) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TransactionProgress(initialTabIndex: tabIndex), // Navigate to specific tab
          ),
        );
      },
      child: SizedBox(
        width: 122, // Fixed width
        height: 88, // Fixed height
        child: Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // Center content vertically
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16.0,
                  color: Colors.black87,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 4.0),
              Text(
                value,
                textAlign: TextAlign.center, // Center text horizontally
                style: TextStyle(
                  fontSize: 21.0,
                  color: textColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }



  Widget _buildTransactionItem({
    required String date,
    required String status,
    required String type,
    required String fundName,
    required String amount,
    required int selectedIndex,
    required List<Map<String, dynamic>> transactions, // Pass transactions list
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TransactionStatus(
              transactions: transactions,
              selectedIndex: selectedIndex,
            ),
          ),
        );
      },
      child: Container(
        width: 125, // Set fixed width
        height: 163,
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              blurRadius: 4.0,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8.0),
            Row(
              children: [
                Text(
                  date,
                  style: const TextStyle(
                    fontSize: 16.0,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(width: 10.0),
                const Icon(Icons.circle, size: 8, color: Colors.grey),
                const SizedBox(width: 10.0),
                _buildStatusBadge(status, Colors.red.shade100, Colors.red),
                const SizedBox(width: 20.0),
                _buildStatusBadge(type, Colors.blue.shade100, Colors.blue.shade900),
                const Spacer(),
                const Icon(
                  Icons.arrow_forward_ios_sharp,
                  color: Colors.black54,
                  size: 20.0,
                ),
              ],
            ),
            const SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    fundName,
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    softWrap: true,
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  amount,
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30.0),
          ],
        ),
      ),
    );
  }


  Widget _buildStatusBadge(String text, Color backgroundColor, Color textColor) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 12.0,
          color: textColor, // ✅ Use the correct text color
        ),
      ),
    );
  }
}
