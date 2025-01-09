import 'package:flutter/material.dart';
import 'TransactionStatus.dart';
class TransactionCompleted extends StatelessWidget {
  const TransactionCompleted({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF2A2E34),
          title: const Text(
            'Transaction Details',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(48.0), // Standard TabBar height
            child: TabBar(
              labelColor: Colors.white, // Active tab text color
              unselectedLabelColor: Colors.white70, // Inactive tab text color
              indicator: const UnderlineTabIndicator(
                borderSide: BorderSide(
                  color: Colors.teal, // Indicator color
                  width: 5.0, // Thickness of the indicator
                ),
                insets: EdgeInsets.fromLTRB(75.0, 0.0, 80.0, 0.0), // Adjusts the length of the indicator
              ),
              tabs: const [
                Tab(text: 'Completed'),
                Tab(text: 'In Progress'),
                Tab(text: 'Failed'),
              ],
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(
                Icons.search,
                color: Colors.white,
                size: 36.0,
              ),
              onPressed: () {
                // Search button functionality
              },
            ),
          ],
        ),
        body: Container(
          color: Colors.white, // Set background color to blue
          child: const TabBarView(
            children: [
              CompletedTransactionsTab(),
              Center(
                child: Text(
                  'In Progress Transactions',
                  style: TextStyle(color: Colors.black), // Black text
                ),
              ),
              Center(
                child: Text(
                  'Failed Transactions',
                  style: TextStyle(color: Colors.black), // Black text
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CompletedTransactionsTab extends StatelessWidget {
  const CompletedTransactionsTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'NOVEMBER 2024',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.black, // Black text
            ),
          ),
        ),
        TransactionCard(
          date: '22 Nov 2024',
          fundName: 'Aditya Birla Sun Life Flexi Cap Fund - IDCW-Regular Plan',
          units: '0.064 Unit',
        ),
        TransactionCard(
          date: '22 Nov 2024',
          fundName: 'Aditya Birla Sun Life Flexi Cap Fund - IDCW-Regular Plan',
          units: '0.067 Unit',
        ),
        TransactionCard(
          date: '22 Nov 2024',
          fundName: 'Aditya Birla Sun Life Flexi Cap Fund - IDCW-Regular Plan',
          units: '0.068 Unit',
        ),
        TransactionCard(
          date: '22 Nov 2024',
          fundName: 'Aditya Birla Sun Life Flexi Cap Fund - IDCW-Regular Plan',
          units: '1.057 Unit',
        ),
        TransactionCard(
          date: '12 Nov 2024',
          fundName: 'Kotak Bluechip Fund',
          units: '0.183 Unit',
          tag: 'PURCHASE-LUMPSUM',
        ),
        TransactionCard(
          date: '11 Nov 2024',
          fundName: 'Some Other Fund',
          units: '0.150 Unit',
        ),
      ],
    );
  }
}

class TransactionCard extends StatelessWidget {
  final String date;
  final String fundName;
  final String units;
  final String? tag;

  const TransactionCard({
    Key? key,
    required this.date,
    required this.fundName,
    required this.units,
    this.tag,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white, // Set background color to white
      child: ListTile(
        onTap: () {
          // Navigate to TransactionStatus
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const TransactionStatus(),
            ),
          );
        },
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              date,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black, // Black text
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios_sharp,
              color: Colors.black54,
              size: 20.0, // Icon size
            ),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 9), // Space between title and subtitle
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    fundName,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black, // Black text
                    ),
                  ),
                ),
                Text(
                  units,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black, // Black text
                  ),
                ),
              ],
            ),
            if (tag != null)
              Container(
                margin: const EdgeInsets.only(top: 8), // Space above the tag
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.teal.shade100,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  tag!,
                  style: const TextStyle(
                    color: Colors.teal,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            const SizedBox(height: 18), // Space below the tag
          ],
        ),
        trailing: null, // No trailing logic as tag is moved to subtitle
      ),
    );
  }
}


