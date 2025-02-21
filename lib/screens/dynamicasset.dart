import 'package:flutter/material.dart';
import 'NoDataPage.dart';

import 'package:flutter/services.dart';

class DynamicAssetAllocation extends StatefulWidget {
  @override
  _DynamicAssetAllocationState createState() => _DynamicAssetAllocationState();
}

class _DynamicAssetAllocationState extends State<DynamicAssetAllocation> {
  String selectedPeriod = "1M";
  @override
  void initState() {

    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF2A2E34),// Light black background
      appBar: AppBar(
        backgroundColor: Color(0xFF2A2E34),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(
              context
            );
          },
        ),
        elevation: 0,
        //leading: Icon(Icons.arrow_back, color: Colors.white),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Dynamic Asset Allocation',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            Text(
              '88 Mutual Fund',
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: Colors.white ,size: 40),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Section
          Padding(
            padding: const EdgeInsets.all(14.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Current Value and Return on investment made 1 month ago",
                  style: TextStyle(fontSize: 13, color: Colors.white60),
                ),
                SizedBox(height: 16),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal, // Allows horizontal scrolling
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 8.0), // Add padding inside the container
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey), // Optional: add a border
                          borderRadius: BorderRadius.circular(20.0), // Optional: add rounded corners
                        ),
                        child: DropdownButton<String>(
                          dropdownColor: Colors.grey[900],
                          value: 'One-time',
                          items: ['One-time', 'SIP']
                              .map((e) => DropdownMenuItem(
                            value: e,
                            child: Text(
                              e,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15), // Increased font size
                            ),
                          ))
                              .toList(),
                          onChanged: (value) {},
                          underline: Container(),
                          icon: Icon(Icons.keyboard_arrow_down,
                              color: Colors.grey, size: 28), // Larger icon
                        ),
                      ),
                      SizedBox(width: 12),
                      Text(
                        "of",
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 15), // Increased font size for consistency
                      ),
                      SizedBox(width: 12),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 30.0), // Add padding inside the container
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white), // Optional: add a border
                          borderRadius: BorderRadius.circular(20.0), // Optional: add rounded corners
                        ),
                        child: DropdownButton<String>(
                          dropdownColor: Colors.grey[900],
                          value: '10 K',
                          items: ['10 K', '20 K', '50 K']
                              .map((e) => DropdownMenuItem(
                            value: e,
                            child: Text(
                              e,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16), // Increased font size
                            ),
                          ))
                              .toList(),
                          onChanged: (value) {},
                          underline: Container(),
                          icon: Icon(Icons.keyboard_arrow_down,
                              color: Colors.white, size: 20), // Larger icon
                        ),
                      ),
                      SizedBox(width: 12),
                      Text(
                        '= INVESTED \n       ₹10 K',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15), // Increased font size for better readability
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 15),
                // Tabs with outline
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.grey[900],
                  ),
                  padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: ["1M", "3M", "6M", "1Y", "3Y", "5Y"]
                        .map((period) => GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedPeriod = period;
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 6, horizontal: 12),
                        decoration: BoxDecoration(
                          color: selectedPeriod == period
                              ? Colors.teal
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          period,
                          style: TextStyle(
                              color: selectedPeriod == period
                                  ? Colors.black
                                  : Colors.white),
                        ),
                      ),
                    ))
                        .toList(),
                  ),
                ),
              ],
            ),
          ),
          Divider(color: Colors.grey),
          // Fund Cards Section
          Expanded(
            child: ListView(
              children: [
                FundCard(
                  fundName: 'Bandhan Balanced Advantage Fund Regular Plan-Growth',
                  currentValue: '10.1 K',
                  minSipAmount: '₹100',
                  returnPercentage: '1.2%',
                ),
                FundCard(
                  fundName: 'Bandhan Balanced Advantage Fund Regular Plan-IDCW',
                  currentValue: '10.1 K',
                  minSipAmount: '₹100',
                  returnPercentage: '1.2%',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class FundCard extends StatelessWidget {
  final String fundName;
  final String currentValue;
  final String minSipAmount;
  final String returnPercentage;

  const FundCard({
    required this.fundName,
    required this.currentValue,
    required this.minSipAmount,
    required this.returnPercentage,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        elevation: 4,
        color: Colors.white, // Set background color to white
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage('assets/Bandhan.png'), // Replace with your image path
                    backgroundColor: Colors.red, // Optional background color
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      fundName,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Image.asset(
                'assets/dynamicg.png', // Ensure the image is in the assets folder
                width: 350, // Adjust width as needed
                height: 60, // Adjust height as needed
                fit: BoxFit.contain, // Adjust fit as needed
              ),
              SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Current Value',
                        style: TextStyle(fontSize: 12, color: Colors.black),
                      ),
                      Text(
                        currentValue,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                            color: Colors.black
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Min SIP Amount',
                        style: TextStyle(fontSize: 12, color: Colors.black),
                      ),
                      Text(
                        minSipAmount,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                            color: Colors.black
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Return%',
                        style: TextStyle(fontSize: 12, color: Colors.black),
                      ),
                      Text(
                        returnPercentage,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold, color: Colors.black
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 15),
              Divider(color: Colors.grey),
              Align(
                alignment: Alignment.centerRight,
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => NoDataPage()), // Navigate to NoDataPage
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.teal),
                    padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                  ),
                  child: Text('Invest Now', style: TextStyle(color: Colors.teal)),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}

