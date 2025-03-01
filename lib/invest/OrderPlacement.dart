import 'package:flutter/material.dart';
import 'dart:convert';
import '../models/transaction.dart';
import '../services/api_service.dart';

class OrderPlacement extends StatefulWidget {
  final Map<String, dynamic> investment;

  const OrderPlacement({super.key, required this.investment});

  @override
  _OrderPlacementState createState() => _OrderPlacementState();
}

class _OrderPlacementState extends State<OrderPlacement> with SingleTickerProviderStateMixin {
  int orderNo = 558490961;
  int folioNo= 1043916066;
  String transactionStatus= "In progress";
  late TabController _tabController;
  int selectedTabIndex = 1; // Default: "One-time"

  DateTime? selectedDate;
  String selectedDuration = "Until I stop"; // Default duration option


  @override
  void initState() {
    super.initState();
    getid();
    _tabController = TabController(length: 2, vsync: this, initialIndex: 1); // Start at "One-time"
    _tabController.addListener(() {
      setState(() {
        selectedTabIndex = _tabController.index;
      });
    });
  }

  Future<void> getid() async {
    try {
      final userId = await ApiService.getUserId();

      if (userId != null) {
        //print("Final User ID: $userId");
      } else {
        //print("No User ID found.");
      }
    } catch (e) {
      //print("Error fetching User ID: $e");
    }
  }


  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  String _formatDate(DateTime? date) {
    if (date == null) return "Select Date";
    String suffix = "th";
    int day = date.day;
    if (day == 1 || day == 21 || day == 31) {
      suffix = "st";
    } else if (day == 2 || day == 22) {
      suffix = "nd";
    } else if (day == 3 || day == 23) {
      suffix = "rd";
    }
    return "$day$suffix of every month";
  }

  void _showDurationOptions() {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)), // Border radius added
      ),
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white, // Background color set to white
            borderRadius: BorderRadius.vertical(top: Radius.circular(25)), // Border radius added
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text(
                  "Until I stop",
                  style: TextStyle(color: Colors.black), // Text color set to black
                ),
                trailing: selectedDuration == "Until I stop"
                    ? const Icon(Icons.radio_button_checked, color: Colors.black) // Black icon
                    : const Icon(Icons.radio_button_off, color: Colors.black), // Black icon
                onTap: () {
                  setState(() {
                    selectedDuration = "Until I stop";
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text(
                  "Number of Months",
                  style: TextStyle(color: Colors.black), // Text color set to black
                ),
                trailing: selectedDuration == "Number of Months"
                    ? const Icon(Icons.radio_button_checked, color: Colors.black) // Black icon
                    : const Icon(Icons.radio_button_off, color: Colors.black), // Black icon
                onTap: () {
                  setState(() {
                    selectedDuration = "Number of Months";
                  });
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }
  void _showCustomPopupSequence(List<String> messages) {
    if (messages.isEmpty) return;

    void showNextPopup(int index) {
      if (index >= messages.length) return; // Stop when all messages are shown

      OverlayEntry? overlayEntry;
      final overlay = Overlay.of(context);
      final animationController = AnimationController(
        duration: const Duration(milliseconds: 300), // Smooth entrance
        vsync: Navigator.of(context),
      );
      final animation = Tween<Offset>(
        begin: const Offset(0, 1), // Start from bottom
        end: const Offset(0, 0), // Move up
      ).animate(CurvedAnimation(
        parent: animationController,
        curve: Curves.easeInOut,
      ));

      overlayEntry = OverlayEntry(
        builder: (context) => Positioned(
          bottom: 80,
          left: MediaQuery.of(context).size.width * 0.05, // Less padding for more width
          right: MediaQuery.of(context).size.width * 0.05, // Less padding for more width
          child: Material(
            color: Colors.transparent,
            child: SlideTransition(
              position: animation,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                decoration: BoxDecoration(
                  color: const Color(0xFF4A4A4A),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Image.asset(
                      'assets/lampy.png',
                      width: 50,
                      height: 50,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        messages[index],
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                        softWrap: true,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );

      overlay.insert(overlayEntry);
      animationController.forward(); // Show popup

      Future.delayed(const Duration(seconds: 3), () {
        animationController.reverse().then((_) {
          overlayEntry?.remove();
          showNextPopup(index + 1); // Show next popup
        });
      });
    }

    showNextPopup(0); // Start with the first message
  }


  void _createTransaction() async {
    if (!mounted) return;

    final userId = await ApiService.getUserId();

    if (!mounted) return;

    if (userId == null ||
        widget.investment['companyName'] == null ||
        widget.investment['amount'] == null) {
      if (mounted) {
        _showCustomPopupSequence(["Transaction failed: Missing required fields"]);
      }
      return;
    }

    setState(() {
      orderNo++;
      folioNo++;
    });

    final amount = widget.investment['amount'] ?? 0.0;
    final navRate = widget.investment['navRate'] ?? 0.0;
    final units = (navRate != 0.0) ? amount / navRate : 0.0;

    final transaction = Transaction(
      userId: userId,
      companyName: widget.investment['companyName'] ?? "Unknown",
      companyImg: widget.investment['companyImg'] ?? "",
      navRate: navRate,
      navDate: widget.investment['date'] ?? "",
      investDate: DateTime.now().toLocal().toString().split(' ')[0],
      orderNo: orderNo,
      units: units,
      folioNo: folioNo,
      transactionStatus: "In progress",
      amount: amount,
    );

    try {
      final response = await ApiService.createTransaction(transaction);

      if (!mounted) return;

      if (response.contains("successful")) {
        if (mounted) {
          _showCustomPopupSequence([
            "Transaction Successful",
            "Investment initiated. Processing may take up to 24 hours.",
            "Track progress in 'In-progress' section of portfolio."
          ]);
        }
      } else {
        if (mounted) {
          _showCustomPopupSequence(["Transaction failed: $response"]);
        }
      }
    } catch (e) {
      if (mounted) {
        _showCustomPopupSequence(["An error occurred: $e"]);
      }
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(185),
        child: Container(
          color: const Color(0xFF2A2E34),
          padding: const EdgeInsets.only(top: 20.0, left: 15.0, right: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  const Text(
                    "Order Placement",
                    style: TextStyle(
                      fontSize: 21.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(5.0),
                    child: widget.investment['companyImg'] != null
                        ? Image.memory(
                      base64Decode(widget.investment['companyImg']),
                      width: 30,
                      height: 30,
                      fit: BoxFit.cover,
                    )
                        : const Icon(Icons.image, size: 30, color: Colors.white),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.investment['companyName'] ?? 'Unknown Fund',
                          style: const TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 5),
                        Text(
                          widget.investment['recommendationType'] ?? 'No Recommendation',
                          style: const TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.w500,
                            color: Colors.white70,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(2, 10, 2, 10),
        child: Column(
          children: [
            Container(
              constraints: const BoxConstraints(minHeight: 300),
              padding: const EdgeInsets.fromLTRB(8, 25, 8, 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25.0),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    child: Theme(
                      data: ThemeData(
                        tabBarTheme: const TabBarTheme(
                          dividerColor: Colors.transparent,
                        ),
                      ),
                      child: TabBar(
                        controller: _tabController,
                        indicator: BoxDecoration(
                          color: Colors.teal,
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        indicatorSize: TabBarIndicatorSize.tab,
                        labelPadding: const EdgeInsets.symmetric(horizontal: 8.0),
                        labelStyle: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                        labelColor: Colors.white,
                        unselectedLabelColor: Colors.black,
                        tabs: const [
                          Tab(text: "SIP"),
                          Tab(text: "One-time"),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 220,
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        _investmentCard("SIP"),
                        _investmentCard("One-time"),
                      ],
                    ),
                  ),

                ],
              ),

            ),
            const SizedBox(height: 10),
            if (selectedTabIndex == 0) _sipSelectionSection(),
            SizedBox(height: selectedTabIndex == 0 ? 40 : 290), // Conditional height
            const Text.rich(
              TextSpan(
                text: "By Continuing, you agree to the fund’s ",
                style: TextStyle(
                  color: Colors.white, // Adjust color based on your background
                  fontSize: 14, // Adjust as needed
                ),
                children: [
                  TextSpan(
                    text: "T&Cs",
                    style: TextStyle(
                      color: Colors.white, // You can change this to blue or another highlight color
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline, // Optional underline effect
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
        bottomNavigationBar: Container(
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF004D40),
                Color(0xFF66B7B0),
              ],
              begin: Alignment.centerRight,
              end: Alignment.centerLeft,
            ),
            borderRadius: BorderRadius.all(Radius.circular(30)),
          ),
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () async {
                _createTransaction();
                final userId = await ApiService.getUserId();
                //print("Investment Details:");
                //print("User ID: ${userId ?? 'Unknown'}");
                //print("Company Name: ${widget.investment['companyName'] ?? 'Unknown'}");
                //print("Company Image: ${widget.investment['companyImg'] ?? ''}"); // Base64 string
                //print("NAV Rate: ${widget.investment['navRate'] ?? 0.0}");
                //print("NAV Date: ${widget.investment['date'] ?? ''}");
                //print("Investment Date: ${DateTime.now().toLocal().toString().split(' ')[0]}");
                setState(() {
                  orderNo++;  // Increment order number
                });
                //print("Order No: $orderNo");
                //final amount = widget.investment['amount'] ?? 0.0;
                //final navRate = widget.investment['navRate'] ?? 0.0;
                //final units = (navRate != 0.0) ? amount / navRate : 0.0;  // Avoid division by zero
                //print("Units: $units");
                setState(() {
                  folioNo++;  // Increment order number
                });
                //print("Folio No: $folioNo");
                //print("Transaction Status: $transactionStatus");
                //print("Amount: $amount");
              },

              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0),
                ),
              ),
              child: const Text(
                "Continue",
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        )
    );
  }

  Widget _sipSelectionSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,  // Changed to white
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "Select monthly installment date",
            style: TextStyle(
              color: Colors.black,  // Changed to black
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 8),
          GestureDetector(
            onTap: () => _selectDate(context),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              decoration: BoxDecoration(
                color: Colors.grey[200],  // Light background for contrast
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _formatDate(selectedDate),
                    style: const TextStyle(color: Colors.black, fontSize: 18),  // Black text
                  ),
                  const Icon(Icons.calendar_month_outlined, color: Colors.black,size: 32,),  // Black icon
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            "How long should this SIP run?",
            style: TextStyle(
              color: Colors.black,  // Changed to black
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 8),
          GestureDetector(
            onTap: _showDurationOptions,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                color: Colors.grey[200],  // Light background for contrast
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    selectedDuration,
                    style: const TextStyle(color: Colors.black, fontSize: 18),  // Black text
                  ),
                  const Icon(Icons.arrow_drop_down, color: Colors.black,size: 34,),  // Black icon
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }


  Widget _investmentCard(String type) {
    int baseAmount = (widget.investment['amount'] ?? 5000).toInt();
    int displayAmount = selectedTabIndex == 0 ? (baseAmount ~/ 10) : baseAmount; // ₹500 for SIP, ₹5000 for One-time

    return Center(
      child: Container(
        width: 450,
        height: 200,
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: const Color(0xFFDEF2F1),
          borderRadius: BorderRadius.circular(15.0),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Amount you want to invest",
              style: TextStyle(fontSize: 16.0, color: Colors.black),
            ),
            const SizedBox(height: 10),
            Text(
              "₹$displayAmount",  // Updated to show ₹500 for SIP
              style: const TextStyle(
                fontSize:40.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 25),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(0, 12, 0, 0),
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(color: Colors.grey, width: 0.5),
                ),
              ),

              child: Text(
                "Minimum $type investment : $displayAmount",
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 14.0, color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }

}
