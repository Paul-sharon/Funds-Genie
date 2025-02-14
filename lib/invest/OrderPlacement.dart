import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class OrderPlacement  extends StatelessWidget {
  final Map<String, dynamic> investment;
  const OrderPlacement ({super.key, required this.investment});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(185), // Increased height
        child: Container(
          color: const Color(0xFF2A2E34), // Background color same as AppBar
          padding: const EdgeInsets.only(top: 20.0, left: 15.0, right: 15.0), // Adjust padding for notch
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center, // Centers content vertically
            children: [
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () {
                      Navigator.pop(context); // Back navigation
                    },
                  ),
                  const Text(
                    "Order Placement",
                    style: TextStyle(
                      fontSize: 21.0, // Slightly bigger for better visibility
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10), // Space between "Order Placement" and image + text
              Row(
                crossAxisAlignment: CrossAxisAlignment.start, // Aligns text properly
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(5.0),
                    child: investment['companyImg'] != null
                        ? Image.memory(
                      base64Decode(investment['companyImg']),
                      width: 30,
                      height: 30,
                      fit: BoxFit.cover,
                    )
                        : const Icon(Icons.image, size: 30, color: Colors.white),
                  ),
                  const SizedBox(width: 15), // Space between image and text
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          investment['companyName'] ?? 'Unknown Fund',
                          style: const TextStyle(
                            fontSize: 20.0, // Adjusted for better readability
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 5), // Space between company name and recommendation type
                        Text(
                          investment['recommendationType'] ?? 'No Recommendation', // Displays recommendation
                          style: const TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.w500, // Slightly lighter than company name
                            color: Colors.white70, // Slightly faded color for better hierarchy
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
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

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),

        child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4.0,
                  spreadRadius: 1.0,
                ),
              ],
            ),

            padding: const EdgeInsets.all(16.0),
            child: Column(

              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),

                const SizedBox(height: 12.0),
                // Text(
                //   'Investment Amount: ₹${investment['amount'] ?? 'N/A'}',
                //   style: const TextStyle(
                //     fontSize: 18.0,
                //     fontWeight: FontWeight.bold,
                //     color: Colors.black,
                //   ),
                // ),
                const SizedBox(height: 200.0),
              ],
            ),
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
              "Continue",
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
