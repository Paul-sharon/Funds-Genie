import 'package:flutter/material.dart';
import 'dynamicasset.dart';
import 'dart:async';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _selectedCategoryIndex = 1;
  Color _borderColor = Colors.blueGrey;
  double _borderWidth = 1.5;

  @override
  void initState() {
    super.initState();
    _startBorderAnimation();
  }

  void _startBorderAnimation() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _borderColor = _borderColor == Colors.blueGrey ? Colors.cyanAccent : Colors.blueGrey;
        _borderWidth = _borderWidth == 1.5 ? 3.0 : 1.5;
      });
    });
  }

  final Map<int, List<Map<String, dynamic>>> _categoryGrids = {
    0: [
      {"icon": Icons.trending_up, "label": "Large Cap", "page": DynamicAssetAllocation()},
      {"icon": Icons.show_chart, "label": "Mid Cap", "page": DynamicAssetAllocation()},
      {"icon": Icons.bar_chart, "label": "Small Cap", "page": DynamicAssetAllocation()},
      {"icon": Icons.pie_chart, "label": "Multi Cap", "page": DynamicAssetAllocation()},
      {"icon": Icons.stacked_line_chart, "label": "Flexi Cap", "page": DynamicAssetAllocation()},
      {"icon": Icons.savings, "label": "ELSS (Tax Savings)", "page": DynamicAssetAllocation()},
      {"icon": Icons.arrow_forward, "label": "View all", "page": DynamicAssetAllocation()},
    ],
    1: [
      {"icon": Icons.savings, "label": "Dynamic assets", "page": DynamicAssetAllocation()},
      {"icon": Icons.bar_chart, "label": "Balanced allocation", "page": BalancedAllocation()},
      {"icon": Icons.pie_chart, "label": "Multi asset Allocation", "page": MultiAssetAllocation()},
      {"icon": Icons.trending_up, "label": "Aggressive Allocation", "page": AggressiveAllocation()},
      {"icon": Icons.credit_card, "label": "Equity saving", "page": EquitySavings()},
      {"icon": Icons.graphic_eq, "label": "Arbitrage Fund", "page": ArbitrageFund()},
      {"icon": Icons.arrow_forward, "label": "View all", "page": ViewAll()},
    ],
    2: [
      {"icon": Icons.water_drop, "label": "Liquid", "page": DynamicAssetAllocation()},
      {"icon": Icons.timeline, "label": "Short Duration", "page": DynamicAssetAllocation()},
      {"icon": Icons.business, "label": "Corporate Bond", "page": DynamicAssetAllocation()},
      {"icon": Icons.warning, "label": "Credit Risk", "page": DynamicAssetAllocation()},
      {"icon": Icons.account_balance, "label": "Government Bond", "page": DynamicAssetAllocation()},
      {"icon": Icons.autorenew, "label": "Dynamic Bond", "page": DynamicAssetAllocation()},
      {"icon": Icons.arrow_forward, "label": "View all", "page": DynamicAssetAllocation()},
    ]
  };

  void _selectCategory(int index) {
    setState(() {
      _selectedCategoryIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E1E1E),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 5),
            child: Column(
              children: [
                _buildPortfolioAnalysisSection(),
                SizedBox(height: 15),
                _buildCategorySection(),
                SizedBox(height: 15),
                _buildPortfolioSyncSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }
  Widget _buildPortfolioAnalysisSection() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFF30B8AC), // Medium teal (middle)
            Color(0xFF155F54), // Darker shade of teal (bottom)
          ],
          begin: Alignment.topCenter, // Start from the top
          end: Alignment.bottomCenter, // End at the bottom
        ),
        borderRadius: BorderRadius.circular(25), // Rounded corners with radius 25
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Text Section
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Genie Portfolio Analysis",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  "Get detailed insights on your portfolio\nand make more informed investment\ndecisions",
                  style: TextStyle(color: Colors.white70, fontSize: 14),
                ),
                const SizedBox(height: 15),
                ElevatedButton(
                  onPressed: () {
                    // Navigate to portfolio analysis screen
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 12),
                  ),
                  child: const Text(
                    "Analyze Portfolio",
                    style: TextStyle(color: Colors.black, fontSize: 14),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10), // Space between text and image

          // Image Section
          Container(
            width: 110, // Adjust width as needed
            height: 170, // Adjust height as needed
            child: ClipRRect(
              child: Image.asset(
                "assets/genies.png", // Replace with actual image
                fit: BoxFit.contain,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategorySection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2E34),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Explore All Mutual Funds",
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildCategoryButton('Equity', 0),
              _buildCategoryButton('Hybrid', 1),
              _buildCategoryButton('Debt', 2),
            ],
          ),
          const SizedBox(height: 20),
          LayoutBuilder(
            builder: (context, constraints) {
              return ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: constraints.maxWidth < 600 ? 280 : 200,
                ),
                child: GridView.count(
                  crossAxisCount: 4,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  children: _categoryGrids[_selectedCategoryIndex]!.map((data) {
                    return AnimatedContainer(
                      duration: const Duration(seconds: 1),
                      curve: Curves.easeInOut,
                      decoration: BoxDecoration(
                        color: const Color(0xFF2A2E34),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: _borderColor,
                          width: _borderWidth,
                        ),
                      ),
                      child: _buildIconButton(data["icon"], data["label"], data["page"]),
                    );
                  }).toList(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPortfolioSyncSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(30)),
        color: Color(0xFFFFD7CA),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                'Update Your External Portfolio',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Icon(Icons.close, color: Colors.black),
            ],
          ),
          const SizedBox(height: 10),
          const Text(
            'Last Updated: 28 Nov 2024',
            style: TextStyle(fontSize: 14, color: Colors.black),
          ),
          const SizedBox(height: 25),
          const Text(
            'Your external portfolio needs frequent syncing to get accurate investment details.',
            style: TextStyle(fontSize: 14, color: Colors.black),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            ),
            child: const Text(
              'Sync External Portfolio',
              style: TextStyle(color: Colors.white),
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget _buildCategoryButton(String text, int index) {
    bool isSelected = _selectedCategoryIndex == index;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: GestureDetector(
        onTap: () => _selectCategory(index),
        child: AnimatedContainer(
          duration: const Duration(seconds: 1),
          decoration: BoxDecoration(
            color: isSelected ? Colors.greenAccent : Colors.transparent,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isSelected ? const Color(0xFF00A299) : Colors.white,
            ),
          ),
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 35),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                color: isSelected ? Colors.black : Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIconButton(IconData icon, String label, Widget page) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => page),
        );
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.teal, size: 25),
          const SizedBox(height: 8),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 12, color: Colors.white),
          ),
        ],
      ),
    );
  }
}

class BalancedAllocation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Balanced Allocation')),
      body: Center(child: Text('Balanced Allocation Page')),
    );
  }
}

class MultiAssetAllocation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Multi Asset Allocation')),
      body: Center(child: Text('Multi Asset Allocation Page')),
    );
  }
}

class AggressiveAllocation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Aggressive Allocation')),
      body: Center(child: Text('Aggressive Allocation Page')),
    );
  }
}

class EquitySavings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Equity Savings')),
      body: Center(child: Text('Equity Savings Page')),
    );
  }
}

class ArbitrageFund extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Arbitrage Fund')),
      body: Center(child: Text('Arbitrage Fund Page')),
    );
  }
}

class ViewAll extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('View All Funds')),
      body: Center(child: Text('View All Funds Page')),
    );
  }
}

