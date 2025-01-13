import 'package:flutter/material.dart';

class Question {
  final String questionText;
  final List<Option> options;

  Question({required this.questionText, required this.options});
}

class Option {
  final String title;
  final String subtitle;

  Option({required this.title, required this.subtitle});
}

class RiskAssessment extends StatelessWidget {
  const RiskAssessment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: RiskAssessmentScreen(
        questions: [
          Question(
            questionText: 'What is your primary investment goal?',
            options: [
              Option(title: 'Capital Preservation', subtitle: 'e.g. Secure initial investment'),
              Option(title: 'Steady Income', subtitle: 'e.g. Fixed returns, lower risk'),
              Option(title: 'Balanced Growth and Income', subtitle: 'e.g. Moderate risk for moderate returns'),
              Option(title: 'Growth', subtitle: 'e.g. Seeking higher returns. Willing to take moderate risks'),
              Option(title: 'Aggressive Growth', subtitle: 'e.g. Maximizing returns, Accepting high risks'),
            ],
          ),
          Question(
            questionText: 'What is your investment time horizon?',
            options: [
              Option(title: 'Less than 1 year', subtitle: ''),
              Option(title: '1-3 years', subtitle: ''),
              Option(title: '3-5 years', subtitle: ''),
              Option(title: '5-10 years', subtitle: ''),
              Option(title: 'More than 10 years', subtitle: ''),
            ],
          ),
          Question(
            questionText: 'What is your risk tolerance with market fluctuations?',
            options: [
              Option(
                title: 'Cannot tolerate any losses',
                subtitle: 'e.g., Uncomfortable with any negative performance',
              ),
              Option(
                title: 'Can tolerate minor losses',
                subtitle: 'e.g., Loss within 5% of investment',
              ),
              Option(
                title: 'Can tolerate moderate losses',
                subtitle: 'e.g., Loss within 10-15% of investment',
              ),
              Option(
                title: 'Comfortable with substantial losses',
                subtitle: 'e.g., Up to 20%',
              ),
              Option(
                title: 'Willing to take significant risks for high potential returns',
                subtitle: 'e.g., Over 25% loss',
              ),
            ],
          ),
          Question(
            questionText: 'How would you react if the value of your investment drops by 20% in a short time?',
            options: [
              Option(title: 'Immediately sell to prevent further losses', subtitle: ''),
              Option(title: 'Sell a portion to reduce risk', subtitle: ''),
              Option(title: 'Do nothing and wait for recovery', subtitle: ''),
              Option(title: 'Buy more, considering it an opportunity', subtitle: ''),
              Option(title: 'Invest more aggressively to increase exposure', subtitle: ''),
            ],
          ),
          Question(
            questionText: 'What is your experience with investments like stocks, mutual funds, or bonds?',
            options: [
              Option(title: 'No experience', subtitle: 'Score: 1'),
              Option(title: 'Limited experience', subtitle: 'e.g., Savings accounts or FD'),
              Option(title: 'Moderate experience', subtitle: 'e.g., Mutual funds or bonds'),
              Option(title: 'Good experience', subtitle: 'e.g., Individual stocks or equity funds'),
              Option(title: 'Extensive experience', subtitle: 'e.g., Active trading or derivatives'),
            ],
          ),
          Question(
            questionText: 'How much of your overall income are you willing to allocate for Equity Asset Class?',
            options: [
              Option(title: 'Less than 10%', subtitle: ''),
              Option(title: '10% to 20%', subtitle: ''),
              Option(title: '20% to 30%', subtitle: ''),
              Option(title: '30% to 50%', subtitle: ''),
              Option(title: 'More than 50%', subtitle: ''),
            ],
          ),
        ],
      ),
    );
  }
}

class RiskAssessmentScreen extends StatefulWidget {
  final List<Question> questions;

  const RiskAssessmentScreen({Key? key, required this.questions}) : super(key: key);

  @override
  _RiskAssessmentScreenState createState() => _RiskAssessmentScreenState();
}

class _RiskAssessmentScreenState extends State<RiskAssessmentScreen> {
  int currentQuestionIndex = 0;
  String? selectedOption;

  @override
  Widget build(BuildContext context) {
    final currentQuestion = widget.questions[currentQuestionIndex];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF2A2E34),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            if (currentQuestionIndex > 0) {
              setState(() {
                currentQuestionIndex--; // Go to the previous question
                selectedOption = null; // Reset selected option for the new question
              });
            }
          },
        ),
        title: const Text(
          'Risk Assessment Test',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            // Question Header
            Text(
              'QUESTION ${currentQuestionIndex + 1}/${widget.questions.length}',
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),

            // Question Text
            Text(
              currentQuestion.questionText,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20),

            // Options
            ...currentQuestion.options.map(
                  (option) => buildOption(context, option.title, option.subtitle),
            ),

            const Spacer(),

            // Next Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                onPressed: () {
                  if (currentQuestionIndex < widget.questions.length - 1) {
                    setState(() {
                      selectedOption = null; // Reset selected option
                      currentQuestionIndex++;
                    });
                  } else {
                    // Handle the end of the questionnaire
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('You have completed the assessment!')),
                    );
                  }
                },
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
          ? Colors.teal
          : const Color(0xFF1F1F1F), // Default background color
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(
          color: Color(0xFF4A3E45),
          width: 1.5,
        ),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          setState(() {
            selectedOption = title;
          });
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 14,
                        color: selectedOption == title ? Colors.white70 : Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              Transform.scale(
                scale: 1.3,
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
