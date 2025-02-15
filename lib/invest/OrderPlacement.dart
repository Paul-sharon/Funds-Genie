import 'package:flutter/material.dart';
import 'dart:convert';

class OrderPlacement extends StatefulWidget {
  final Map<String, dynamic> investment;

  const OrderPlacement({super.key, required this.investment});

  @override
  _OrderPlacementState createState() => _OrderPlacementState();
}

class _OrderPlacementState extends State<OrderPlacement> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int selectedTabIndex = 1; // Default: "One-time"

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {
        selectedTabIndex = _tabController.index;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(185), // Increased height
        child: Container(
          color: const Color(0xFF2A2E34),
          padding: const EdgeInsets.only(top: 20.0, left: 15.0, right: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  const Text(
                    "Order Placement",
                    style: TextStyle(
                      fontSize: 21.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(5.0),
                    child: widget.investment['companyImg'] != null
                        ? Image.memory(
                      base64Decode(widget.investment['companyImg']),
                      width: 30,
                      height: 30,
                      fit: BoxFit.cover,
                    )
                        : const Icon(Icons.image, size: 30, color: Colors.white),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.investment['companyName'] ?? 'Unknown Fund',
                          style: const TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 5),
                        Text(
                          widget.investment['recommendationType'] ?? 'No Recommendation',
                          style: const TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.w500,
                            color: Colors.white70,
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
        padding: const EdgeInsets.all(16.0),
        child: Container(
          width: 400,
          height: 300, // Set a fixed width for consistency
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.white, // White background for the entire block
            borderRadius: BorderRadius.circular(25.0),
            border: Border.all(color: Colors.grey.shade300), // Light border
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25.0),
                ),
                child: Theme(
                  data: ThemeData(
                    tabBarTheme: TabBarTheme(
                      dividerColor: Colors.transparent, // ✅ Removes the default underline
                    ),
                  ),
                  child: TabBar(
                    controller: _tabController,
                    indicator: BoxDecoration(
                      color: Colors.teal,
                      borderRadius: BorderRadius.circular(25.0), // Adjust for smoother corners
                    ),
                    indicatorSize: TabBarIndicatorSize.tab, // Ensures full width of the tab
                    labelPadding: EdgeInsets.symmetric(horizontal: 8.0), // Adjust padding if needed
                    labelColor: Colors.white,
                    unselectedLabelColor: Colors.black,
                    tabs: const [
                      Tab(text: "SIP"),
                      Tab(text: "One-time"),
                    ],
                  ),
                ),
              ),
              SizedBox(height:20),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    _investmentCard("SIP"),
                    _investmentCard("One-time"),
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
                const SnackBar(
                  content: Text(
                    "Investment initiated. May take up to 24 hours to process.",
                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  backgroundColor: Colors.blueGrey,
                  duration: Duration(seconds: 3),
                ),
              );

              Future.delayed(const Duration(seconds: 4), () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
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
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0),
              ),
            ),
            child: const Text(
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

  Widget _investmentCard(String type) {
    return Center(
      child: Container(
        width: 450, // Adjust to match the image
        height: 200,
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: Color(0xFFDEF2F1), // Matches the card background in image
          borderRadius: BorderRadius.circular(15.0),
          border: Border.all(color: Colors.grey.shade300), // Light border
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Amount you want to invest",
              style: TextStyle(fontSize: 16.0, color: Colors.black),
            ),
            const SizedBox(height: 10),
            Text(
              "₹${widget.investment['amount'] ?? '5000'}",
              style: const TextStyle(
                fontSize: 28.0,
                fontWeight: FontWeight.bold,
                color: Colors.black, // Set text color to black
              ),
            ),
            const SizedBox(height: 15),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 8),
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(color: Colors.grey, width: 0.5),
                ),
              ),
              child: Text(
                "Minimum $type investment : ₹5000",
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 14.0, color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
