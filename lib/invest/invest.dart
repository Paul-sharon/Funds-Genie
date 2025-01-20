import 'package:flutter/material.dart';
import '../screens/dashboard.dart';
import 'FundDetailsPage.dart';
import '../portfolio/portfolio.dart';
import '../More/Morepage.dart';

class Invest extends StatefulWidget {
  @override
  _InvestState createState() => _InvestState();
}

class _InvestState extends State<Invest> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 24),
                  OngoingNFOsSection(),
                  SizedBox(height: 24),
                  GenieRecommendationSection(),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
class OngoingNFOsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Ongoing NFOs (5)', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
        SizedBox(height: 8),
        Text('Explore New Fund offerings', style: TextStyle(color: Colors.grey, fontSize: 14)),
        SizedBox(height: 16),
        Container(
          decoration: BoxDecoration(color: Color(0xFFFFFFFF), borderRadius: BorderRadius.circular(8)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('UNION ACTIVE MOMENTUM FUND REGULAR IDCW PAYOUT',
                    style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold)),
                Text('Equity Other', style: TextStyle(color: Colors.grey.shade600, fontSize: 12, fontWeight: FontWeight.bold)),
                SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InfoTile(title: 'Open Date', value: '28 Nov', valueColor: Colors.black),
                    InfoTile(title: 'Close Date', value: '12 Dec', valueColor: Colors.black),
                    InfoTile(title: 'Risk', value: 'Very High', valueColor: Colors.red),
                  ],
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            DotsIndicator(),
            Text(
              'View more ->',
              style: TextStyle(color: Colors.blue, fontSize: 14),
            ),
          ],
        ),
      ],
    );
  }
}

class GenieRecommendationSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF66B7B0),
                Color(0xFF155F54),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Genie Recommendation',
                style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'Expert handpicked collection for \n mutual funds curated for you',
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TabItem(title: 'Large Cap'),
                  TabItem(title: 'Mid Cap'),
                  TabItem(title: 'Small Cap'),
                  TabItem(title: 'Debt'),
                ],
              ),
              SizedBox(height: 10),
              Divider(color: Colors.white),
              SizedBox(height: 16),
              RecommendationTile(
                avatarText: 'CR',
                fundName: 'Canara Robeco Blue \nChip Equity Fund - \nRegular Growth',
                returnPercentage: '17.87%',
              ),
              RecommendationTile(
                avatarText: 'BB',
                fundName: 'BARODA BNP \nPARIBAS LARGE \nCAP FUND - REGULAR',
                returnPercentage: '17.77%',
              ),
            ],
          ),
        ),
        SizedBox(height: 16),
      ],
    );
  }
}

class RecommendationTile extends StatelessWidget {
  final String avatarText;
  final String fundName;
  final String returnPercentage;

  RecommendationTile({
    required this.avatarText,
    required this.fundName,
    required this.returnPercentage,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to FundDetailsPage when tapped
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FundDetailsPage(
              avatarText: avatarText,
              fundName: fundName,
              returnPercentage: returnPercentage,
            ),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: Color(0xFF2A2E34),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.black,
                      child: Text(
                        avatarText,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        fundName,
                        style: TextStyle(color: Colors.white, fontSize: 16),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 12),
              Text(
                returnPercentage,
                style: TextStyle(color: Colors.green, fontSize: 14, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class InfoTile extends StatelessWidget {
  final String title;
  final String value;
  final Color valueColor;

  InfoTile({required this.title, required this.value, this.valueColor = Colors.black});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
        ),
        Text(
          value,
          style: TextStyle(color: valueColor, fontSize: 14, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}

class DotsIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(radius: 4, backgroundColor: Colors.white),
        SizedBox(width: 4),
        CircleAvatar(radius: 4, backgroundColor: Colors.grey),
        SizedBox(width: 4),
        CircleAvatar(radius: 4, backgroundColor: Colors.grey),
      ],
    );
  }
}

class TabItem extends StatelessWidget {
  final String title;

  TabItem({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
    );
  }
}
