import 'package:flutter/material.dart';
import 'package:mutualfund_gtl/invest/invest.dart';
import '../screens/dashboard.dart';
import 'TransactionCompleted.dart';
import '../More/Morepage.dart';

class Portfolio extends StatefulWidget {
  @override
  _PortfolioState createState() => _PortfolioState();
}

class _PortfolioState extends State<Portfolio> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: const Color(0xFF2A2E34),
          title: Row(
            children: [
              const CircleAvatar(
                backgroundImage: AssetImage('assets/paul.jpg'),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Welcome,',
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                  Text(
                    'SHARON',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              const Icon(Icons.search_rounded, color: Colors.white, size: 36.0),
            ],
          ),
        ),
        Expanded(
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
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: const [
                        Text(
                          "Transaction Summary  ",
                          style: TextStyle(
                            fontSize: 18.0,
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
                    const SizedBox(height: 5.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildSummaryCard("11", "Completed", Colors.green.shade100),
                        _buildSummaryCard("12", "In Progress", Colors.orange.shade100),
                        _buildSummaryCard("525", "    Failed    ", Colors.red.shade100),
                      ],
                    ),
                    const SizedBox(height: 10.0),
                    Expanded(
                      child: ListView(
                        children: [
                          _buildTransactionItem(
                            date: "26 Nov 2024",
                            status: "IN PROGRESS",
                            type: "LUMPSUM",
                            fundName: "BARODA BNP PARIBAS LARGE\nCAP FUND - REGULAR\nGROWTH",
                            amount: "₹10,000",
                          ),
                          _buildTransactionItem(
                            date: "26 Nov 2024",
                            status: "IN PROGRESS",
                            type: "LUMPSUM",
                            fundName: "BARODA BNP PARIBAS LARGE\nCAP FUND - REGULAR\nGROWTH",
                            amount: "₹5,000",
                          ),
                          _buildTransactionItem(
                            date: "26 Nov 2024",
                            status: "IN PROGRESS",
                            type: "LUMPSUM",
                            fundName: "Axis Mid Cap Fund - Regular\nGrowth",
                            amount: "₹100",
                          ),
                        ],
                      ),
                    ),
                    Center(
                      child: TextButton(
                        onPressed: () {
                          // Handle "View more" action here
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
        ),
      ],
    );
  }

  Widget _buildSummaryCard(String title, String value, Color backgroundColor) {
    return GestureDetector(
      onTap: () {
        if (value == "Completed") {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => TransactionCompleted()),
          );
        }
      },
      child: Container(
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Column(
          children: [
            Text(
              value,
              style: const TextStyle(
                fontSize: 16.0,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 4.0),
            Text(
              title,
              style: const TextStyle(
                fontSize: 14.0,
                color: Colors.black54,
              ),
            ),
          ],
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
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
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
                  fontSize: 14.0,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(width: 25.0),
              _buildStatusBadge(status, Colors.red.shade100),
              const SizedBox(width: 20.0),
              _buildStatusBadge(type, Colors.blue.shade100),
              const Spacer(),
              const Icon(
                Icons.arrow_forward_ios_sharp,
                color: Colors.black54,
                size: 20.0,
              ),
            ],
          ),
          const SizedBox(height: 8.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                fundName,
                style: const TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              Text(
                amount,
                style: const TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          const SizedBox(height: 30.0),
        ],
      ),
    );
  }

  Widget _buildStatusBadge(String text, Color backgroundColor) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 12.0,
          color: Colors.black87,
        ),
      ),
    );
  }
}
