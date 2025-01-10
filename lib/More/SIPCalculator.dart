import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

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
        title: const Text('SIP Calculator'),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildContainer(
              child: Column(
                children: [
                  SizedBox(
                    height: 250,
                    child: PieChart(
                      PieChartData(
                        sections: [
                          PieChartSectionData(
                            color: Colors.blue,
                            radius: 40,
                          ),
                          PieChartSectionData(
                            color: Colors.green,
                            radius: 40,
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
                      _legend(Color(0xFF0288D1), 'Invested Amount'),
                      const SizedBox(width: 20),
                      _legend(Color(0xFF4CAF50), 'Est Return'),
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
              child: InvestmentCalculator(),
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
        _buildValueSection('Invested', '₹30.00 L'),
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
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: highlight ? Colors.blue[100] : Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Text(label, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: highlight ? Colors.blue[900] : Colors.black),
          ),
        ],
      ),
    );
  }
}

class InvestmentCalculator extends StatefulWidget {
  @override
  _InvestmentCalculatorState createState() => _InvestmentCalculatorState();
}

class _InvestmentCalculatorState extends State<InvestmentCalculator> {
  double _monthlyInvestment = 25000;
  double _timePeriod = 10;
  double _rateOfReturn = 12;
  late TextEditingController _rateController;

  @override
  void initState() {
    super.initState();
    _rateController = TextEditingController(text: _rateOfReturn.toStringAsFixed(1));
  }

  @override
  void dispose() {
    _rateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sliderRow(
          label: 'Monthly Investment',
          value: _monthlyInvestment,
          min: 500,
          max: 100000,
          divisions: 199,
          onChanged: (value) => setState(() => _monthlyInvestment = value),
        ),
        _sliderRow(
          label: 'Time Period (in years)',
          value: _timePeriod,
          min: 1,
          max: 40,
          divisions: 39,
          onChanged: (value) => setState(() => _timePeriod = value),
        ),
        const SizedBox(height: 16),
        const Text(
          'Expected Rate of Return (% p.a)',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: _rateController,
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
          ),
          keyboardType: TextInputType.number,
          onSubmitted: (value) => setState(() {
            _rateOfReturn = double.tryParse(value) ?? _rateOfReturn;
          }),
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(
                'Monthly Investment: ₹$_monthlyInvestment\nTime Period: $_timePeriod years\nRate of Return: $_rateOfReturn%',
              ),
            ));
          },
          child: const Text('Calculate'),
        ),
      ],
    );
  }

  Widget _sliderRow({
    required String label,
    required double value,
    required double min,
    required double max,
    required int divisions,
    required ValueChanged<double> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            activeTrackColor: Color(0xFF028274),
            inactiveTrackColor: Color(0xFF028274),
            thumbColor: Color(0xFF028274),
            overlayColor: Color(0xFF028274),
          ),
          child: Slider(
            value: value,
            min: min,
            max: max,
            divisions: divisions,
            label: value.toStringAsFixed(0),
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}
