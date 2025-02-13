import 'package:flutter/material.dart';
import 'package:mutualfund_gtl/RiskAssessment/Riskometer.dart';
import 'screens/loginpage.dart';
import 'RiskAssessment/Riskassessment.dart';
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
      home: LoginPage(),
      //home: RiskAssessment(),
      // home: Riskometer(),
    );
  }
}