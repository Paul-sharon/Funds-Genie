import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class NoDataPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0, // Removes shadow
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context), // Go back
        ),
        // title: Text(
        //   "No Data Available",
        //   style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        // ),
        // centerTitle: true,
      ),
      backgroundColor: Colors.white, // Clean white background
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Lottie Animation
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Lottie.asset(
              'assets/nodata.json', // Replace with your Lottie file
              width: MediaQuery.of(context).size.width * 0.8, // 80% of screen width
              height: MediaQuery.of(context).size.height * 0.4, // 40% of screen height
              fit: BoxFit.contain,
              repeat: true,
            ),
          ),

          SizedBox(height: 20),

          // Message
          Text(
            "Oops! No Data Found",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),

          SizedBox(height: 10),

          // Subtext
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: Text(
              "We couldn't find any data to display. Try again later!",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.black54),
            ),
          ),

          SizedBox(height: 30),
          // Go Back Button
          ElevatedButton(
            onPressed: () => Navigator.pop(context), // Go back
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.teal,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
            ),
            child: Text(
              "Go Back",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}

