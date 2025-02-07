import 'package:flutter/material.dart';
import 'dart:convert';

class FundDetailsPage extends StatelessWidget {
  final Map<String, dynamic> investment;

  const FundDetailsPage({super.key, required this.investment});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(investment['companyName'] ?? 'Fund Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Fund Details Card
              Card(
                color: const Color(0xFF2A2E34),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ),
                elevation: 4.0,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.black,
                            backgroundImage: investment['companyImg'] != null
                                ? MemoryImage(base64Decode(investment['companyImg']))
                                : null,
                          ),
                          const SizedBox(width: 12.0),
                          Expanded(
                            child: Text(
                              investment['companyName'] ?? 'Unknown Fund',
                              style: const TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12.0),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                            decoration: BoxDecoration(
                              color: Colors.grey[700],
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: const Text(
                              'Growth',
                              style: TextStyle(
                                fontSize: 12.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Equity • Large Cap',
                            style: TextStyle(color: Colors.grey[400]),
                          ),
                          Row(
                            children: [
                              const Icon(Icons.bar_chart, color: Colors.red, size: 16.0),
                              const SizedBox(width: 4.0),
                              Text(
                                investment['risk'] ?? 'N/A',
                                style: const TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 5.0),
                      Divider(color: Colors.grey[800]),
                      const SizedBox(height: 5.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'NAV (Nov 29, 2024)',
                                style: TextStyle(color: Colors.grey[400]),
                              ),
                              const SizedBox(height: 4.0),
                              const Text(
                                '₹61.02',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              const Text(
                                '+0.47% (1 D Change)',
                                style: TextStyle(color: Colors.green),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              const Text(
                                '5 Y CAGR',
                              ),
                              const SizedBox(height: 4.0),
                              Text(
                                investment['returnPercentage'] != null ? investment['returnPercentage'].toString() : 'N/A',
                                style: const TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
              // Invest Button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: ElevatedButton(
                  onPressed: () {
                    // Add action here
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                  ),
                  child: const Text(
                    "Invest",
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
