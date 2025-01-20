import 'dart:math';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart'; // For PieChart

class Sipcalculator extends StatefulWidget {
  const Sipcalculator({super.key});

  @override
  State<Sipcalculator> createState() => _SipcalculatorState();
}

class _SipcalculatorState extends State<Sipcalculator> {
  double monthlyInvestment = 25000; // Initial investment
  int timePeriod = 10; // Initial time period in years
  double rateOfReturn = 12; // Initial rate of return (in %)

  double investedAmount = 0;
  double estimatedReturn = 0;
  double totalValue = 0;

  @override
  void initState() {
    super.initState();
    _calculateSIP();
  }

  void _calculateSIP() {
    setState(() {
      double r = rateOfReturn / 100 / 12; // Monthly rate of return
      int n = timePeriod * 12; // Total number of months
      investedAmount = monthlyInvestment * n;
      totalValue = monthlyInvestment *
          (pow((1 + r), n) - 1) *
          (1 + r) /
          r; // SIP formula
      estimatedReturn = totalValue - investedAmount;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1B1C20),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text(
          'SIP Calculator',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF2A2E34),
        foregroundColor: const Color(0xFFFFFFFF),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: Column(
            children: [
              // Pie Chart with legend
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: 370,
                      width:250,
                      child: PieChart(
                        PieChartData(
                          sections: [
                            PieChartSectionData(
                              color:  Colors.blue,
                              value: investedAmount,
                              title: '',
                              titleStyle: const TextStyle(
                                fontSize: 1,
                                color: Colors.transparent,
                              ),
                            ),
                            PieChartSectionData(
                              color: Colors.green,
                              value: estimatedReturn,
                              title: '',
                              titleStyle: const TextStyle(
                                fontSize: 1,
                                color: Colors.transparent,
                              ),
                            ),
                          ],
                          centerSpaceRadius: 120, // Increase this value for a thinner chart
                          sectionsSpace: 2, // Adjust the gap between sections
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    // Legend
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _legend(const Color(0xFF0288D1), 'Invested Amount'),
                        const SizedBox(width: 20),
                        _legend(const Color(0xFF4CAF50), 'Est Return'),
                      ],
                    ),
                    const SizedBox(height: 16),
                    // Summary row with improved handling of overflow
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: _buildSummaryColumn(
                            label: 'Invested',
                            value: '₹${(investedAmount / 100000).toStringAsFixed(2)}L',
                            backgroundColor: const Color(0xFFF1F1F1),
                          ),
                        ),
                        const Text(
                          '+',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Expanded(
                          child: _buildSummaryColumn(
                            label: 'Est Return',
                            value: '₹${(estimatedReturn / 100000).toStringAsFixed(2)}L',
                            backgroundColor: const Color(0xFFF1F1F1),
                          ),
                        ),
                        const Text(
                          '=',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Expanded(
                          child: _buildSummaryColumn(
                            label: 'Total Value',
                            value: '₹${(totalValue / 100000).toStringAsFixed(2)}L',
                            backgroundColor: const Color(0xFFE8F2FF),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    // Slider Section
                    _buildSliderSection(
                      title: 'Monthly Investment',
                      value: monthlyInvestment,
                      min: 500,
                      max: 100000,
                      divisions: 100,
                      onChanged: (value) {
                        setState(() {
                          monthlyInvestment = value;
                          _calculateSIP();
                        });
                      },
                    ),
                    const SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("500",style:
                        TextStyle(fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),),
                        const Text("1L",style:
                        TextStyle(fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey)),
                      ],
                    ),
                    const SizedBox(height: 16),
                    _buildSliderSection(
                      title: 'Time Period (in years)',
                      value: timePeriod.toDouble(),
                      min: 1,
                      max: 40,
                      divisions: 39,
                      onChanged: (value) {
                        setState(() {
                          timePeriod = value.toInt();
                          _calculateSIP();
                        });
                      },
                    ),
                    const SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("1Y",style:
                        TextStyle(fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),),
                        const Text("40Y",style:
                        TextStyle(fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey)),
                      ],
                    ),
                    const SizedBox(height: 16),
                    // Rate of Return Input
                    _buildRateOfReturnInput(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSummaryColumn({
    required String label,
    required String value,
    required Color backgroundColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.grey,
            ),
            overflow: TextOverflow.ellipsis, // Prevent overflow
          ),
          const SizedBox(height: 4),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              overflow: TextOverflow.ellipsis, // Prevent overflow
            ),
          ),
        ],
      ),
    );
  }


  Widget _buildSliderSection({
    required String title,
    required double value,
    required double min,
    required double max,
    required int divisions,
    required ValueChanged<double> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(
                  fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
            ),
            Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(

                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Column(
                children: [

                  const SizedBox(height: 4),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      value > 499
                          ? '₹${value.toStringAsFixed(0)}' // If value is greater than 500, show in ₹ format
                          : '${value.toStringAsFixed(0)}Y', // If value is 500 or less, show in L format

                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      overflow: TextOverflow.ellipsis, // Prevent overflow
                    ),
                  ),
                ],
              ),
            )

          ],
        ),
        Slider(
          value: value,
          min: min,
          max: max,
          divisions: divisions,
          label: '₹${value.toStringAsFixed(0)}',
          activeColor: Colors.green, // Set the active color to green
          inactiveColor: Colors.grey, // Optional: Set the inactive color
          onChanged: onChanged,
        ),
      ],
    );
  }

  Widget _buildRateOfReturnInput() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Expected Rate of Return (%)',
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        SizedBox(
          width: 80,
          child: TextField(
            keyboardType: TextInputType.number,
            onChanged: (value) {
              setState(() {
                rateOfReturn = double.tryParse(value) ?? 12;
                _calculateSIP();
              });
            },
            decoration: const InputDecoration(
              hintText: '12%',
              border: OutlineInputBorder(),
            ),
          ),
        ),
      ],
    );
  }
}

Widget _legend(Color color, String label) {
  return Row(
    children: [
      CircleAvatar(radius: 5, backgroundColor: color),
      const SizedBox(width: 8),
      Text(label, style: const TextStyle(fontSize: 14,color: Colors.black)),
    ],
  );
}
