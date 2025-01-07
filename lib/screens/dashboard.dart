import 'package:flutter/material.dart';
import 'dynamicasset.dart';
class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xFF2A2E34),
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage('assets/paul.jpg'),
            ),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome,',
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
                Text(
                  'SHARON',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Spacer(),
            Icon(Icons.search_rounded, color: Colors.white, size: 36.0),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: Column(
          children: [
            Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(30)),
                color: Color(0xFF2A2E34),
              ),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(width: 40),
                      Text(
                        'Explore All Mutual Funds',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 30),
                      CategoryButtonsRow(),
                      SizedBox(height: 40),
                      FundOptionsGrid(),
                      SizedBox(height: 80),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: _buildPortfolioSyncCard(),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        backgroundColor: Color(0xFF2A2E34),
        selectedItemColor: Colors.greenAccent,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.pie_chart),
            label: 'Portfolio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.attach_money),
            label: 'Invest',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.more_horiz),
            label: 'More',
          ),
        ],
      ),
      backgroundColor: Colors.black,
    );
  }

  Widget _buildPortfolioSyncCard() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(30)),
        color: Color(0xFFFFD7CA),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
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
          SizedBox(height: 10),
          Text(
            'Last Updated: 28 Nov 2024',
            style: TextStyle(fontSize: 14, color: Colors.black),
          ),
          SizedBox(height: 25),
          Text(
            'Your external portfolio needs frequent syncing to get accurate investment details.',
            style: TextStyle(fontSize: 14, color: Colors.black),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            ),
            child: Text(
              'Sync External Portfolio',
              style: TextStyle(color: Colors.white),
            ),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}

class FundOptionsGrid extends StatelessWidget {
  final List<Map<String, dynamic>> fundOptions = [
    {'title': 'Dynamic Asset', 'icon': Icons.savings, 'route': DynamicAsset()},
    {'title': 'Balanced Allocation', 'icon': Icons.bar_chart, 'route': BalancedAllocation()},
    {'title': 'Multi Asset Allocation', 'icon': Icons.pie_chart, 'route': MultiAssetAllocation()},
    {'title': 'Aggressive Allocation', 'icon': Icons.trending_up, 'route': AggressiveAllocation()},
    {'title': 'Equity Savings', 'icon': Icons.money, 'route': EquitySavings()},
    {'title': 'Arbitrage Fund', 'icon': Icons.swap_horiz, 'route': ArbitrageFund()},
    {'title': 'View All', 'icon': Icons.arrow_forward, 'route': ViewAll()},
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 4,
      crossAxisSpacing: 10,
      mainAxisSpacing: 20,
      physics: NeverScrollableScrollPhysics(),
      children: fundOptions.map((fund) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => fund['route']),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              color: Color(0xFF2A2E34),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Color(0xFF4A3E45), // Border color
                width: 1.5, // Border width (adjust as needed)
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(fund['icon'], size: 30, color: Colors.white),
                SizedBox(height: 8),
                Text(
                  fund['title'],
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}

class CategoryButtonsRow extends StatefulWidget {
  @override
  _CategoryButtonsRowState createState() => _CategoryButtonsRowState();
}

class _CategoryButtonsRowState extends State<CategoryButtonsRow> {
  int _selectedCategoryIndex = 1; // Default to "Hybrid"

  void _selectCategory(int index) {
    setState(() {
      _selectedCategoryIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildCategoryButton('Equity', 0),
        _buildCategoryButton('Hybrid', 1),
        _buildCategoryButton('Debt', 2),
      ],
    );
  }

  Widget _buildCategoryButton(String text, int index) {
    bool isSelected = _selectedCategoryIndex == index;
    return GestureDetector(
      onTap: () => _selectCategory(index),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.greenAccent : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? Color(0xFF00A299) : Colors.white,
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isSelected ? Colors.black : Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

// Placeholder pages for navigation

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
