import 'package:flutter/material.dart';
import 'Riskassessment2.dart';
class RiskAssessment extends StatelessWidget {
  const RiskAssessment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const RiskAssessmentScreen(),
    );
  }
}

class RiskAssessmentScreen extends StatefulWidget {
  const RiskAssessmentScreen({Key? key}) : super(key: key);

  @override
  _RiskAssessmentScreenState createState() => _RiskAssessmentScreenState();
}

class _RiskAssessmentScreenState extends State<RiskAssessmentScreen> {
  String? selectedOption;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF2A2E34), // Black app bar background
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            // Navigate back to the previous screen
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Risk Assessment Test',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            // Question Header
            const Text(
              'QUESTION 1/6',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),

            // Question Text
            const Text(
              'What is your primary investment goal?',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20),

            // Options
            buildOption(
              context,
              'Capital Preservation',
              'e.g. Secure initial investment',
            ),
            buildOption(
              context,
              'Steady Income',
              'e.g. Fixed returns, lower risk',
            ),
            buildOption(
              context,
              'Balanced Growth and Income',
              'e.g. Moderate risk for moderate returns',
            ),
            buildOption(
              context,
              'Growth',
              'e.g. Seeking higher returns. Willing to take moderate risks',
            ),
            buildOption(
              context,
              'Aggressive Growth',
              'e.g. Maximizing returns, Accepting high risks',
            ),

            const Spacer(),

            // Next Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Add navigation or further logic here
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RiskAssessment2(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal, // Consistently teal background
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                child: const Text(
                  'Next',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.black,
    );
  }

  Widget buildOption(BuildContext context, String title, String subtitle) {
    return Card(
      color: selectedOption == title
          ? Colors.teal // Change to cyan when selected
          : const Color(0xFF1F1F1F), // Default background color
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12), // Rounded corners
        side: const BorderSide(
          color: Color(0xFF4A3E45), // Grey border color
          width: 1.5, // Border width
        ),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12), // Ripple effect respects corners
        onTap: () {
          setState(() {
            selectedOption = title; // Set the selected option on tap
          });
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
          child: Row(
            children: [
              // Text on the left
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white, // Text color
                      ),
                    ),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 14,
                        color: selectedOption == title
                            ? Colors.white70 // Lighter grey text when selected
                            : Colors.grey, // Default grey text
                      ),
                    ),
                  ],
                ),
              ),
              // Radio button on the right
              Transform.scale(
                scale: 1.3, // Adjust size
                child: Radio<String>(
                  value: title,
                  groupValue: selectedOption,
                  onChanged: (value) {
                    setState(() {
                      selectedOption = value!;
                    });
                  },
                  activeColor: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Placeholder for SIPCalculator screen
class SIPCalculator extends StatelessWidget {
  const SIPCalculator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SIP Calculator'),
      ),
      body: const Center(
        child: Text('SIP Calculator Screen'),
      ),
    );
  }
}
