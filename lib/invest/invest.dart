import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';
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
    _pageController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  void _startAutoScroll() {
    Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (!mounted) return;
      setState(() {
        currentPage = (currentPage + 1) % 4;
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
    if (data != null) {
      setState(() {
        investments = data;
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
        opacity: _fadeAnimation,
        child: Container(
          color: const Color(0xFF1E1E1E),
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Ongoing NFOs Section with Animation
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
                          itemCount: 4,
                          itemBuilder: (context, index) {
                            return AnimatedContainer(
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
                                        Icon(Icons.upcoming_outlined, color: Colors.black),
                                        const SizedBox(width: 15),
                                        Flexible(
                                          child: const Text(
                                            "UNION ACTIVE MOMENTUM FUND REGULAR IDCW PAYOUT",
                                            style: TextStyle(
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
                                    SizedBox(height:10),
                                    Row(
                                      children: [
                                        const SizedBox(width: 40),
                                        const Text(
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
                                      children: [
                                        const Text(
                                          "Open date",
                                          style: TextStyle(fontSize: 15, color: Colors.grey),
                                        ),
                                        const SizedBox(width: 30),
                                        const Text(
                                          "Close date",
                                          style: TextStyle(fontSize: 15, color: Colors.grey),
                                        ),
                                        const SizedBox(width: 40),
                                        const Text(
                                          "Risk",
                                          style: TextStyle(fontSize: 15, color: Colors.grey),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        const SizedBox(width: 3),
                                        const Text(
                                          "28 Nov",
                                          style: TextStyle(
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
                                        const Text(
                                          "||| very High",
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.red,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 13),
                                  ],
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
                              // Add your sync action here
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent, // Transparent background
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
                                        height: 1.0, // Reduce spacing above the text
                                      ),
                                    ),
                                    Container(
                                      height: 2, // Thickness of the underline
                                      width: 72, // Match text width or adjust as needed
                                      color: Colors.grey, // Match underline color
                                      margin: const EdgeInsets.only(top: 2), // Space between text and underline
                                    ),
                                  ],
                                ),
                                const SizedBox(width: 4), // Add spacing between text and arrow
                                Icon(
                                  Icons.arrow_forward, // Use forward arrow icon
                                  color: Colors.white, // Match icon color
                                  size: 16, // Adjust icon size
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
                        Color(0xFF00766C), // Darker shade
                        // Lighter shade
                        Color(0xFF60BAAE), // Darker shade
                      ],
                      stops: [0.0, 0.25],
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
                            children: [
                              const Text(
                                "Genie Recommendation",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              const Text(
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
                            width: 130, // Width of the image container
                            height: 105, // Height of the image container
                            alignment: Alignment.centerRight,
                            child: Image.asset(
                              'assets/Genieclouds.png',
                              fit: BoxFit
                                  .contain, // Ensures the image scales to fit
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      Flexible(
                        child: isLoading
                            ? Center(
                          child: Lottie.asset(
                            'assets/Loading3.json',  // Replace with your Lottie JSON file
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
                                    fontSize: 18, fontWeight: FontWeight.bold),
                                unselectedLabelStyle: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.normal),
                                tabs: [
                                  Tab(text: 'Large Cap'),
                                  Tab(text: ' Mid Cap '),
                                  Tab(text: 'Small Cap'),
                                  Tab(text: '   Debt  '),
                                  Tab(text: '  Other  '),
                                ],
                              ),
                              SizedBox(height: 15),
                              Expanded(
                                child: TabBarView(
                                  children: [
                                    buildInvestmentList('l', investments, context), // Large Cap
                                    buildInvestmentList('m', investments, context), // Mid Cap
                                    buildInvestmentList('s', investments, context), // Small Cap
                                    buildInvestmentList('d', investments, context), // Debt
                                    buildInvestmentList('o', investments, context), // Other
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
        ));
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

                const SizedBox(width: 12), // Space between image and text

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
      mainAxisSize: MainAxisSize.min, // Ensures row takes minimal space
      children: List.generate(
        4,
            (index) => AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: currentIndex == index ? 12 : 10, // Increase the size
          height: currentIndex == index ? 12 : 10, // Increase the size
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: currentIndex == index ? Colors.white : Colors.grey,
          ),
        ),
      ),
    );
  }
}

