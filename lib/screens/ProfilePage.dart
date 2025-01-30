import 'package:flutter/material.dart';
import '../components/custom_app_bar.dart';

class ProfilePage extends StatefulWidget {
  final String username;

  const ProfilePage({Key? key, required this.username}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(username: widget.username),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // White Container
            Container(
              padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 20),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(25)),
                color: Colors.white,
              ),
              child: Column(
                children: [
                  SizedBox(height: 20),
                  // Image from Assets
                  Container(
                    height: 150,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        'assets/gold.png', // Ensure this asset is added in pubspec.yaml
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  const Text(
                    "Get Started on your Investment Journey!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  const Text(
                    "Activate your BSE STAR membership in a few simple steps.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12,horizontal: 120),
                    ),
                    onPressed: () {},
                    child: const Text(
                      "Activate Now",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Black Container
            Container(
              padding: const EdgeInsets.symmetric(vertical: 35,horizontal: 20),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(25)),
                color: Color(0xFF2A2E34),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Membership Details",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        "Demat",
                        style: TextStyle(color: Colors.grey,fontSize: 16),
                      ),
                      Row(
                        children: [
                          Icon(Icons.circle, color: Colors.green, size: 12),
                          SizedBox(width: 5),
                          Text(
                            "Active",
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        "Physical",
                        style: TextStyle(color: Colors.grey,fontSize: 16),
                      ),
                      Row(
                        children: [
                          Icon(Icons.circle, color: Colors.grey, size: 12),
                          SizedBox(width: 5),
                          Text(
                            "Inactive",
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 35,horizontal: 20),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(25)),
                color: Color(0xFF2A2E34),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Contact Details",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        "Email",
                        style: TextStyle(color: Colors.grey,fontSize: 16),
                      ),
                      Row(
                        children: [
                          SizedBox(width: 5),
                          Text(
                            "sandeepnair@gmail.com",
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        "Mobile",
                        style: TextStyle(color: Colors.grey,fontSize: 16),
                      ),
                      Row(
                        children: [
                          SizedBox(width: 5),
                          Text(
                            "8089352312",
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 35, horizontal: 20),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(25)),
                color: Color(0xFF2A2E34),
              ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Bank Details Title
                  const Text(
                    "Bank Details",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // HDFC Bank Details Row
                  Row(
                    children: [
                      Image.asset('assets/hdfcimg.png', width: 50, height: 50),
                      const SizedBox(width: 20),
                      Expanded(   // <-- FIXES OVERFLOW
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              "HDFC BANK LTD",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                              overflow: TextOverflow.ellipsis,  // <-- Prevents text overflow
                            ),
                            SizedBox(height: 5),
                            Text(
                              "Acc. No: XXXXXXXXXX3488",
                              style: TextStyle(color: Colors.grey, fontSize: 14),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 35, horizontal: 20),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(25)),
                color: Color(0xFF2A2E34),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Nominee Details",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          // Add nominee action
                        },
                        child: Column(
                          children: [
                            const Row(
                              children: [
                                Text(
                                  "Add Nominee",
                                  style: TextStyle(color: Colors.white, fontSize: 14),
                                ),
                                SizedBox(width: 5),
                                Icon(Icons.add, color: Colors.white, size: 18),
                              ],
                            ),
                            const SizedBox(height: 5),
                            Container(
                              height: 2, // height of the underline
                              width: 100, // width of the underline, adjust as needed
                              color: Colors.white, // color of the underline
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const Center(
                    child: Text(
                      "No nominees added yet.",
                      style: TextStyle(color: Colors.grey, fontSize: 14),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
