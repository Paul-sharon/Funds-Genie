import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';
import 'package:intl/intl.dart';
import '../screens/NoDataPage.dart';
import '../services/api_service.dart';
import 'FundDetailsPage.dart';
import 'package:lottie/lottie.dart';

class Invest extends StatefulWidget {
  const Invest({super.key});

  @override
  State<Invest> createState() => _InvestState();
}

class _InvestState extends State<Invest> with TickerProviderStateMixin {
  List<Map<String, dynamic>> investments = [];
  late PageController _pageController;
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;
  int currentPage = 0;
  bool isLoading = true;
  Timer? _autoScrollTimer;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _fadeAnimation =
        CurvedAnimation(parent: _fadeController, curve: Curves.easeIn);

    fetchInvestments();
    _startAutoScroll();
    _fadeController.forward();
  }

  @override
  void dispose() {
    _autoScrollTimer?.cancel(); // Cancel timer to prevent memory leaks
    _pageController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  void _startAutoScroll() {
    _autoScrollTimer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (!mounted) return;
      setState(() {
        // Adjust modulus for 5 items
        currentPage = (currentPage + 1) % 5;
        _pageController.animateToPage(
          currentPage,
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeInOut,
        );
      });
    });
  }

  Future<void> fetchInvestments() async {
    final data = await ApiService.getInvestments();
    if (!mounted) return; // Prevent state updates after widget disposal

    setState(() {
      investments = data ?? [];
      isLoading = false;
    });
  }

  // Helper to format dates if needed
  String formatDate(String dateString) {
    // Customize as needed
    return dateString;
  }
  String formattedDate(String dateString) {
    try {
      DateTime date = DateTime.parse(dateString);
      return DateFormat('d MMM').format(date); // e.g. "10 Feb"
    } catch (e) {
      return dateString; // fallback to original string if parsing fails
    }
  }
  @override
  Widget build(BuildContext context) {
    // Reverse the list to get latest investments first
    final reversedInvestments = investments.reversed.toList();
    // Get the last 5 investments (if available)
    final lastFiveInvestments = reversedInvestments.length >= 5
        ? reversedInvestments.sublist(0, 5)
        : reversedInvestments;

    return FadeTransition(
      opacity: _fadeAnimation,
      child: Container(
        color: const Color(0xFF1E1E1E),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Ongoing NFOs Section with Animation (Upper Carousel)
              Container(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color(0xFF2A2E34),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Ongoing NFOs (5)",
                      style: TextStyle(
                        fontSize: 21,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      "Explore new fund offerings",
                      style: TextStyle(fontSize: 15, color: Colors.white70),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 190,
                      child: PageView.builder(
                        controller: _pageController,
                        itemCount: lastFiveInvestments.length,
                        itemBuilder: (context, index) {
                          final investment = lastFiveInvestments[index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => FundDetailsPage(investment: investment),
                                ),
                              );
                            },
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeInOut,
                              width: 346,
                              margin: const EdgeInsets.symmetric(horizontal: 8),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        if (investment['companyImg'] != null)
                                          ClipRRect(
                                            borderRadius: BorderRadius.circular(8),
                                            child: Image.memory(
                                              base64Decode(investment['companyImg']),
                                              width: 40,
                                              height: 40,
                                              fit: BoxFit.cover,
                                            ),
                                          )
                                        else
                                          Container(
                                            width: 40,
                                            height: 40,
                                            color: Colors.grey[300],
                                          ),
                                        const SizedBox(width: 15),
                                        Flexible(
                                          child: Text(
                                            investment['companyName'] ?? 'Default Company Name',
                                            style: const TextStyle(
                                              fontSize: 16,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      children: const [
                                        SizedBox(width: 40),
                                        Text(
                                          "Equity other",
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 20),
                                    Row(
                                      children: const [
                                        Text(
                                          "Open date",
                                          style: TextStyle(fontSize: 15, color: Colors.grey),
                                        ),
                                        SizedBox(width: 30),
                                        Text(
                                          "Close date",
                                          style: TextStyle(fontSize: 15, color: Colors.grey),
                                        ),
                                        SizedBox(width: 40),
                                        Text(
                                          "Risk",
                                          style: TextStyle(fontSize: 15, color: Colors.grey),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        const SizedBox(width: 3),
                                        Text(
                                          formattedDate(investment['date'] ?? 'Unknown Date'),
                                          style: const TextStyle(
                                            fontSize: 16,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(width: 45),
                                        const Text(
                                          "12 Dec",
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(width: 63),
                                        Text(
                                          investment['riskType'] ?? 'N/A',
                                          style: const TextStyle(
                                            fontSize: 16,
                                            color: Colors.red,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                    // Add more details if needed
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        DotsIndicator(currentIndex: currentPage),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => NoDataPage()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                            Colors.transparent, // Transparent background
                            elevation: 0, // No elevation
                            padding: EdgeInsets.zero, // Remove default padding
                          ),
                          child: Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'View more',
                                    style: TextStyle(
                                      color: Colors.white, // Match text color
                                      fontSize: 15, // Adjust size as needed
                                      height: 1.0,
                                    ),
                                  ),
                                  Container(
                                    height: 2, // Underline thickness
                                    width: 72,
                                    color: Colors.grey,
                                    margin:
                                    const EdgeInsets.only(top: 2), // Spacing
                                  ),
                                ],
                              ),
                              const SizedBox(width: 4),
                              Icon(
                                Icons.arrow_forward,
                                color: Colors.white,
                                size: 16,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // Genie Recommendation Section
              Container(
                height: MediaQuery.of(context).size.height * 0.5,
                margin: const EdgeInsets.all(8.0),
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      const Color(0xFF00766C),
                      const Color(0xFF60BAAE),
                    ],
                    stops: const [0.0, 0.25],
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              "Genie Recommendation",
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              "Expert handpicked collection for \nmutual funds curated for you",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                        Container(
                          width: 130,
                          height: 105,
                          alignment: Alignment.centerRight,
                          child: Image.asset(
                            'assets/Genieclouds.png',
                            fit: BoxFit.contain,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Flexible(
                      child: isLoading
                          ? Center(
                        child: Lottie.asset(
                          'assets/Loading3.json',
                          width: 140,
                          height: 140,
                          fit: BoxFit.cover,
                        ),
                      )
                          : DefaultTabController(
                        length: 5,
                        child: Column(
                          children: [
                            const TabBar(
                              isScrollable: true,
                              indicatorColor: Colors.white,
                              labelColor: Colors.white,
                              unselectedLabelColor: Colors.white,
                              tabAlignment: TabAlignment.start,
                              indicatorWeight: 1,
                              labelStyle: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                              unselectedLabelStyle: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal),
                              tabs: [
                                Tab(text: 'Large Cap'),
                                Tab(text: ' Mid Cap '),
                                Tab(text: 'Small Cap'),
                                Tab(text: '   Debt  '),
                                Tab(text: '  Other  '),
                              ],
                            ),
                            const SizedBox(height: 15),
                            Expanded(
                              child: TabBarView(
                                children: [
                                  buildInvestmentList('l', investments, context),
                                  buildInvestmentList('m', investments, context),
                                  buildInvestmentList('s', investments, context),
                                  buildInvestmentList('d', investments, context),
                                  buildInvestmentList('o', investments, context),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildInvestmentList(String type,
      List<Map<String, dynamic>> investments, BuildContext context) {
    List<Map<String, dynamic>> filteredInvestments = investments
        .where((investment) => investment['investType'] == type)
        .toList();

    if (filteredInvestments.isEmpty) {
      return const Center(
        child: Text(
          'No investments available',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      );
    }

    return ListView.builder(
      itemCount: filteredInvestments.length,
      itemBuilder: (context, index) {
        final investment = filteredInvestments[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => FundDetailsPage(investment: investment),
              ),
            );
          },
          child: Container(
            margin: const EdgeInsets.all(6),
            padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                // Fund Logo
                if (investment['companyImg'] != null)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.memory(
                      base64Decode(investment['companyImg']),
                      width: 40,
                      height: 40,
                      fit: BoxFit.cover,
                    ),
                  )
                else
                  const Icon(Icons.image, size: 40, color: Colors.grey),
                const SizedBox(width: 12),
                // Fund Name and Returns
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        investment['companyName'] ?? 'Unknown Fund',
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                // Return Percentage & Time Period
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "${investment['returnPercentage']}%",
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "${investment['returnsIn']} return (p.a)",
                      style: TextStyle(color: Colors.grey, fontSize: 14),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class DotsIndicator extends StatelessWidget {
  final int currentIndex;

  const DotsIndicator({super.key, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(
        5,
            (index) => AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: currentIndex == index ? 12 : 10,
          height: currentIndex == index ? 12 : 10,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: currentIndex == index ? Colors.white : Colors.grey,
          ),
        ),
      ),
    );
  }
}
