import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'loginpage.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    // Fade-in animation
    _controller = AnimationController(vsync: this, duration: Duration(seconds: 2));
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);

    _controller.forward();

    // Navigate to LoginPage after 5 seconds
    Timer(Duration(seconds: 5), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()), // Direct navigation
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Gradient Background
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFFFFFFFF), // Pure White
                  Color(0xFFFFFFFF), // Champagne Gold
                  Color(0xFFFFFFFF), // Deep Gold
                ],
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Full-Screen Image
              FadeTransition(
                opacity: _fadeAnimation,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20), // Add horizontal padding
                  child: Image.asset(
                    'assets/FundsLauch.png', // Your splash image
                    width: MediaQuery.of(context).size.width * 0.9, // Slightly smaller width
                    height: MediaQuery.of(context).size.height * 0.7, // Adjusted height for better balance
                    fit: BoxFit.contain, // Ensures it fits within the given size
                  ),
                ),
              ),

              SizedBox(height: 10), // Small gap between image and animation

              // Lottie Animation for Modern Touch
              Lottie.asset(
                'assets/Animation.json', // Your Lottie animation
                width: 100,
              ),

              SizedBox(height: 10), // Small gap between animation and text

              // Animated App Name
              FadeTransition(
                opacity: _fadeAnimation,
                child: Text(
                  "FundsGenie",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.black, // Changed to black for contrast
                    letterSpacing: 1.5,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
