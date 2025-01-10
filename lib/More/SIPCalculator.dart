import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/services.dart';
import 'Morepage.dart';

class SIPCalculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SIPCalculatorScreen(),
    );
  }
}
class SIPCalculatorScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF2A2E34), // Black app bar background
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            SystemChrome.setSystemUIOverlayStyle(
              const SystemUiOverlayStyle(
                systemNavigationBarColor: Color(0xFF2A2E34), // Set to match your app theme
                systemNavigationBarIconBrightness: Brightness.light, // White icons
              ),
            );
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Morepage()),
            );
          },
        ),
        title: const Text(
          'SIP Calculator',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildContainer(
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 250,
                    child: PieChart(
                      PieChartData(
                        sections: [
                          PieChartSectionData(
                            color: Colors.blue,
                            radius: 40,
                            value: 30,
                              showTitle: false
                          ),
                          PieChartSectionData(
                            color: Colors.green,
                            radius: 40,
                            value:28,
                              showTitle: false
                          ),
                        ],
                        sectionsSpace: 2,
                        centerSpaceRadius: 100,
                        startDegreeOffset: -90,
                      ),
                    ),
                  ),
                  const SizedBox(height: 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _legend(const Color(0xFF0288D1), 'Invested Amount'),
                      const SizedBox(width: 20),
                      _legend(const Color(0xFF4CAF50), 'Est Return'),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            _buildContainer(
              child: const InvestmentSummary(),
            ),
            const SizedBox(height: 16),
            _buildContainer(
              child: const InvestmentCalculator(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContainer({required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 8.0,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: child,
    );
  }

  Widget _legend(Color color, String label) {
    return Row(
      children: [
        CircleAvatar(radius: 5, backgroundColor: color),
        const SizedBox(width: 8),
        Text(label, style: const TextStyle(fontSize: 14)),
      ],
    );
  }
}

class InvestmentSummary extends StatelessWidget {
  const InvestmentSummary({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildValueSection('Invested', '₹30.0 L'),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: Text('+', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        ),
        _buildValueSection('Est Return', '₹28.08 L'),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: Text('=', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        ),
        _buildValueSection('Total Value', '₹58.08 L', highlight: true),
      ],
    );
  }

  Widget _buildValueSection(String label, String value, {bool highlight = false}) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: highlight ? Colors.blue[100] : Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Text(label, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: highlight ? Colors.blue[900] : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}

class InvestmentCalculator extends StatefulWidget {
  const InvestmentCalculator({Key? key}) : super(key: key);

  @override
  _InvestmentCalculatorState createState() => _InvestmentCalculatorState();
}

class _InvestmentCalculatorState extends State<InvestmentCalculator> {
  double _monthlyInvestment = 25000;
  double _timePeriod = 10;
  double _rateOfReturn = 12;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Monthly Investment Section
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Monthly Investment',
              style: TextStyle(fontSize: 18),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Text(
                _monthlyInvestment.toStringAsFixed(0),
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Slider(
          value: _monthlyInvestment,
          min: 500,
          max: 100000,
          divisions: 199,
          label: _monthlyInvestment.toStringAsFixed(0),
          activeColor: const Color(0xFF028274),
          inactiveColor: Colors.grey,
          onChanged: (value) {
            setState(() {
              _monthlyInvestment = value;
            });
          },
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text('500'),
            Text('1L'),
          ],
        ),
        const SizedBox(height: 20),

        // Time Period Section
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Time Period (in years)',
              style: TextStyle(fontSize: 18),
            ),
            Container(
              width: 65,
              height: 30,
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Center(
                child: Text(
                  _timePeriod.toStringAsFixed(0),
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Slider(
          value: _timePeriod,
          min: 1,
          max: 40,
          divisions: 39,
          label: _timePeriod.toStringAsFixed(0),
          activeColor: const Color(0xFF028274),
          inactiveColor: Colors.grey,
          onChanged: (value) {
            setState(() {
              _timePeriod = value;
            });
          },
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text('1Y'),
            Text('40Y'),
          ],
        ),
        const SizedBox(height: 20),

        // Rate of Return Section
        const Text(
          'Expected Rate of Return (% p.a)',
          style: TextStyle(fontSize: 18),
        ),
        TextField(
          decoration: const InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(12.0)),
            ),
          ),
          keyboardType: TextInputType.number,
          controller: TextEditingController(text: _rateOfReturn.toStringAsFixed(1)),
          onSubmitted: (value) {
            setState(() {
              _rateOfReturn = double.tryParse(value) ?? _rateOfReturn;
            });
          },
        ),
        const SizedBox(height: 20),

        // Calculate Button
        ElevatedButton(
          onPressed: () {
            final snackBar = SnackBar(
              content: Text(
                  'Monthly Investment: ₹$_monthlyInvestment\nTime Period: $_timePeriod years\nRate of Return: $_rateOfReturn%'),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          },
          child: const Text('Calculate'),
        ),
      ],
    );
  }
}
