import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class FundDetailsPage extends StatelessWidget {
  final Map<String, dynamic> investment;
  String formatDate(String dateString) {
    try {
      print("Received date: $dateString"); // Debugging log
      DateTime parsedDate = DateTime.parse(dateString);
      String formattedDate = DateFormat('MMM dd, yyyy').format(parsedDate);
      print("Formatted date: $formattedDate"); // Debugging log
      return formattedDate;
    } catch (e) {
      print("Error formatting date: $e"); // Debugging log
      return 'Invalid Date';
    }
  }

  const FundDetailsPage({super.key, required this.investment});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF2A2E34),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Fund Details Card
              Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ),
                elevation: 4.0,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(0.0), // Adjust for rounded corners
                            child: investment['companyImg'] != null
                                ? Image.memory(
                              base64Decode(investment['companyImg']),
                              width: 40, // Set width and height as needed
                              height: 40,
                              fit: BoxFit.cover,
                            )
                                : Container(
                              width: 40,
                              height: 40,
                              color: Colors.black, // Placeholder color
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12.0),
                      const SizedBox(height: 12.0),
                      Text(
                        investment['companyName'] ?? 'Unknown Fund',
                        style: const TextStyle(
                          fontSize: 21.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 5),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 26.0, vertical: 4.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12.0),
                              border: Border.all( // Adding border
                                color: Colors.black12, // Border color
                                width: 1.5, // Border thickness
                              ),
                            ),
                            child: const Text(
                              'Growth',
                              style: TextStyle(
                                fontSize: 12.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                'Equity • ',
                                style: TextStyle(color: Colors.black54),
                              ),
                              Text(
                                investment['recommendationType'] ?? 'Others',
                                style: TextStyle(color: Colors.black54),
                              ),
                              Text(
                                ' • ',
                                style: TextStyle(color: Colors.black54),
                              ),
                              const Icon(Icons.bar_chart, color: Colors.red, size: 16.0),
                              const SizedBox(width: 4.0),
                              Text(
                                investment['riskType'] ?? 'N/A',
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
                      const SizedBox(height: 5.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'NAV (',
                                    style: TextStyle(color: Colors.black54),
                                  ),
                                  Text(
                                    formatDate(investment['date'] ?? ''), // Format the date here
                                    style: TextStyle(color: Colors.black54),
                                  ),
                                  Text(
                                    ')',
                                    style: TextStyle(color: Colors.black54),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4.0),
                              Row(
                                children: [
                                  Text(
                                    '₹${investment['navRate'] != null ? investment['navRate'].toString() : 'N/A'} ',
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  const SizedBox(width: 8.0), // Add spacing between elements
                                  const Text(
                                    '+0.47% (1 D Change)',
                                    style: TextStyle(color: Colors.green),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                '${investment['returnsIn'] ?? '5'} Y CAGR   ',
                                style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 15.0, // Set font size to 16
                                ),
                              ),

                              const SizedBox(height: 4.0),
                              Text(
                                '${investment['returnPercentage'] != null ? investment['returnPercentage'].toString() : 'N/A'}%  ',
                                style: const TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
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
              Center(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color(0xFF66B7B0),
                        Color(0xFF155F54),
                      ],
                      begin: Alignment.centerRight,
                      end: Alignment.centerLeft,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Fund Rating",
                        style: TextStyle(
                          fontSize: 23,
                          fontFamily: 'serif',
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Geojit Rating
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 48, vertical: 5),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "3",
                                      style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.orange,
                                      ),
                                    ),
                                    Icon(
                                      Icons.star,
                                      color: Colors.orange,
                                      size: 15,
                                    ),
                                  ],
                                ),
                                SizedBox(width: 16),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "GEOJIT",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.green,
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      "AVERAGE",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          // Morningstar Rating
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "4",
                                      style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.green,
                                      ),
                                    ),
                                    Icon(
                                      Icons.star,
                                      color: Colors.green,
                                      size: 15,
                                    ),
                                  ],
                                ),
                                SizedBox(width: 16),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "MORNINGSTAR",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.red,
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      "GOOD",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  color: Color(0xFF2A2E34),
                  borderRadius: BorderRadius.circular(25.0),
                ),
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Scheme Details",
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 16.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Expense Ratio",
                          style: TextStyle(color: Colors.grey[400], fontSize: 17),
                        ),
                        Text(
                          "1.66% (as on Oct 31, 2024)",
                          style: TextStyle(color: Colors.white, fontSize: 17),
                        ),
                      ],
                    ),
                    Divider(color: Colors.grey[800]), // Updated to 800
                    SizedBox(height: 10), // Updated spacing

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Exit Load", style: TextStyle(color: Colors.grey[400], fontSize: 17)),
                        Text("1.0%", style: TextStyle(color: Colors.white, fontSize: 17)),
                      ],
                    ),
                    Divider(color: Colors.grey[800]),
                    SizedBox(height: 10),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("AUM (Fund Size)", style: TextStyle(color: Colors.grey[400], fontSize: 17)),
                        Text("14580.92 Cr", style: TextStyle(color: Colors.white, fontSize: 17)),
                      ],
                    ),
                    Divider(color: Colors.grey[800]),
                    SizedBox(height: 10),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Lock-In", style: TextStyle(color: Colors.grey[400], fontSize: 17)),
                        Text("No lock in", style: TextStyle(color: Colors.white, fontSize: 17)),
                      ],
                    ),
                    Divider(color: Colors.grey[800]),
                    SizedBox(height: 10),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Age", style: TextStyle(color: Colors.grey[400], fontSize: 17)),
                        Text("14y 4m (since Aug 20, 2010)", style: TextStyle(color: Colors.white, fontSize: 17)),
                      ],
                    ),
                    Divider(color: Colors.grey[800]),
                    SizedBox(height: 10),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF004D40),
              Color(0xFF66B7B0),
            ],
            begin: Alignment.centerRight,
            end: Alignment.centerLeft,
          ),
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    "Investment initiated. May take up to 24 hours to process.",
                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  backgroundColor: Colors.blueGrey,
                  duration: Duration(seconds: 3),
                ),
              );

              Future.delayed(Duration(seconds: 4), () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      "Track progress in the 'In-progress' section of your portfolio.",
                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    backgroundColor: Colors.green,
                    duration: Duration(seconds: 3),
                  ),
                );
              });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              padding: EdgeInsets.symmetric(vertical: 16.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0),
              ),
            ),
            child: Text(
              "Invest",
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
