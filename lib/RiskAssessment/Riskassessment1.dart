import 'package:flutter/material.dart';

void main() {
  runApp(const RiskAssessment());
}

class RiskAssessment extends StatelessWidget {
  const RiskAssessment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: RiskAssessmentScreen(),
    );
  }
}

class RiskAssessmentScreen extends StatefulWidget {
  @override
  _RiskAssessmentScreenState createState() => _RiskAssessmentScreenState();
}

class _RiskAssessmentScreenState extends State<RiskAssessmentScreen> {
  String? selectedOption;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF2A2E34),
        title: const Text(
          'Risk Assessment Test',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Colors.white),
        ),
        centerTitle: true,
        leading: const Icon(Icons.arrow_back),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Question Header
            const Text(
              'QUESTION 3/8',
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

            // Option 1
            buildOption(
              context,
              'Capital Preservation',
              'e.g. Secure initial investment',
            ),

            // Option 2
            buildOption(
              context,
              'Steady Income',
              'e.g. Fixed returns, lower risk',
            ),

            // Option 3
            buildOption(
              context,
              'Balanced Growth and Income',
              'e.g. Moderate risk for moderate returns',
            ),

            // Option 4
            buildOption(
              context,
              'Growth',
              'e.g. Seeking higher returns. Willing to take moderate risks',
            ),

            // Option 5
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
                onPressed: selectedOption != null
                    ? () {
                  // Add your navigation or action here
                }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: selectedOption != null
                      ? Colors.teal
                      : Colors.grey,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Next',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: InkWell(
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
                        color: selectedOption == title
                            ? Colors.white // White text on selected background
                            : Colors.white, // Default white text
                      ),
                    ),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 14,
                        color: selectedOption == title
                            ? Colors.white70 // Grey text on selected background
                            : Colors.grey, // Default grey text
                      ),
                    ),
                  ],
                ),
              ),
              // Scaled Radio button on the right
              Transform.scale(
                scale: 1.3, // Adjust this value to make the radio button larger
                child: Radio<String>(
                  value: title,
                  groupValue: selectedOption,
                  onChanged: (value) {
                    setState(() {
                      selectedOption = value;
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
