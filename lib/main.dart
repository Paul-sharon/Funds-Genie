import 'package:flutter/material.dart';
import 'package:mutualfund_gtl/RiskAssessment/Riskometer.dart';
import 'package:mutualfund_gtl/screens/SplashScreen.dart';

void main() => runApp(MutualFundApp());

class MutualFundApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      theme: ThemeData.dark().copyWith(
        primaryColor: Color(0xFF0A0E21),
        scaffoldBackgroundColor: Color(0xFF0A0E21),
      ),
      home: SplashScreen(),
      // home: Riskometer(),
    );
  }
}