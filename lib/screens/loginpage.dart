import 'package:flutter/material.dart';
import 'package:mutualfund_gtl/screens/ForgotPasswordScreen.dart';
import '../models/user.dart' as model_user;
import 'registerpage.dart';
import 'homenavbar.dart';
import '../services/api_service.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isPasswordVisible = false; // To manage password visibility

  // Login function using ApiService
  void _showCustomPopup(String message) {
    OverlayEntry overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        bottom: 50, // Adjust this for how high it appears
        left: 20,
        right: 20,
        child: SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, 1),
            end: const Offset(0, 0),
          ).animate(CurvedAnimation(
            parent: AnimationController(
              duration: const Duration(milliseconds: 400),
              vsync: Navigator.of(context),
            )..forward(),
            curve: Curves.easeOut,
          )),
          child: Container(
            height: 55,
            width: 370,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF88D8D2), // Lighter shade of teal
                  Color(0xFF66B7B0), // Medium teal
                  Color(0xFF155F54), // Darker shade of teal
                ],
                begin: Alignment.centerRight,
                end: Alignment.centerLeft,
              ),
              borderRadius: BorderRadius.all(Radius.circular(25)),
            ),
            child: Center(
              child: Text(
                message,
                style: const TextStyle(
                  fontWeight: FontWeight.bold, // Stronger for impact
                  fontSize: 22, // Slightly larger for readability
                  color: Colors.white,
                  fontFamily: 'SF Pro Display', // Premium Apple-style font
                  letterSpacing: 1.5, // Extra spacing for a luxury feel
                  wordSpacing: 2.0, // Makes it more premium
                  shadows: [
                    Shadow(
                      blurRadius: 4.0,
                      color: Colors.black45, // Subtle shadow for depth
                      offset: Offset(2, 2),
                    ),
                  ],
                  decoration: TextDecoration.none, // No underline
                ),
              ),
            ),

          ),
        ),
      ),
    );

    Overlay.of(context).insert(overlayEntry);

    // Remove after 2 seconds
    Future.delayed(const Duration(seconds: 2), () {
      overlayEntry.remove();
    });
  }

  void _login() async {
    if (_formKey.currentState!.validate()) {
      final String email = _usernameController.text.trim();
      final String password = _passwordController.text.trim();

      final String result = await ApiService.loginUser(email, password);

      if (result == 'Login successful!') {
        final model_user.User? user = await ApiService.fetchCurrentUser();
        if (user != null) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => Homenavbar(
                username: user.name ?? 'User',
                email: user.email ?? 'Email not available',
                phoneNumber: user.phoneNumber ?? 'Phone number not available',
              ),
            ),
          );
        } else {
          _showCustomPopup("Failed to fetch user details.");
        }
      } else {
        _showCustomPopup("Invalid email or password.");
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background gradient
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  Color(0xFF88D8D2),
                  Color(0xFF66B7B0),
                  Color(0xFF155F54),
                  // Darker shade of teal (right)
                ],
                begin: Alignment.centerRight, // Start from the top
                end: Alignment.centerLeft, // End at the bottom
              ),
              borderRadius: BorderRadius.circular(
                  25), // Rounded corners with radius 25
            ),
            child: const Padding(
              padding: EdgeInsets.only(top: 60.0, left: 22),
              child: Text(
                'Hello\nSign in!',
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          // Foreground content
          Padding(
            padding: const EdgeInsets.only(top: 200.0),
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
                color: Colors.white,
              ),
              height: double.infinity,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        Center(
                          child: Image.asset(
                            'assets/FG.png',
                            // Make sure this file exists in your assets folder
                            width: 700, // Adjust size as needed
                            height: 200,
                            fit: BoxFit.contain,
                          ),
                        ),
                        // Email Input
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: _usernameController,
                          style: const TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            labelText: "Email",
                            // Label above input field
                            labelStyle: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black, // Black label text
                            ),
                            hintText: "Enter your email",
                            hintStyle: const TextStyle(
                              color: Colors.grey, // Light gray hint text
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            // White background
                            suffixIcon: const Icon(
                              Icons.email,
                              color: Colors.grey,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              // Rounded corners
                              borderSide: BorderSide(
                                color: Colors.grey
                                    .shade300, // Light gray border
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: Colors.grey.shade400,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                color: Colors.blue, // Blue border when focused
                                width: 1.5,
                              ),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Email cannot be empty.";
                            }
                            if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(
                                value)) {
                              return "Enter a valid email address.";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        // Password Input
                        TextFormField(
                          controller: _passwordController,
                          obscureText: !_isPasswordVisible,
                          style: const TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            labelText: "Password",
                            // Label above input
                            labelStyle: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black, // Black label
                            ),
                            hintText: "Enter Password",
                            hintStyle: const TextStyle(
                              color: Colors.grey, // Light gray hint text
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            // White background
                            suffixIcon: IconButton(
                              icon: Icon(
                                _isPasswordVisible ? Icons.visibility : Icons
                                    .visibility_off,
                                color: Colors.grey,
                              ),
                              onPressed: () {
                                setState(() {
                                  _isPasswordVisible = !_isPasswordVisible;
                                });
                              },
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              // Rounded corners
                              borderSide: BorderSide(
                                color: Colors.grey
                                    .shade300, // Light gray border
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: Colors.grey.shade400,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                color: Colors.blue, // Blue border when focused
                                width: 1.5,
                              ),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Password cannot be empty.";
                            }
                            // You can add more password validations here if needed (e.g., min length, special characters, etc.)
                            return null;
                          },
                        ),
                        const SizedBox(height: 40),
                        GestureDetector(
                          onTap: () {
                            // Navigate to ForgotPasswordPage
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ForgotPasswordScreen()),
                            );
                          },
                          child: const Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              'Forgot Password?',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                                color: Color(0xff281537),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                        // Sign In Button
                        GestureDetector(
                          onTap: _login,
                          child: Container(
                            height: 55,
                            width: 370,
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Color(0xFF88D8D2),
                                  // Lighter shade of teal (left)
                                  Color(0xFF66B7B0),
                                  // Medium teal (middle)
                                  Color(0xFF155F54),
                                  // Darker shade of teal (right)
                                ],
                                begin: Alignment.centerRight,
                                // Start from the left
                                end: Alignment.centerLeft, // End at the right
                              ),
                              borderRadius: BorderRadius.all(
                                  Radius.circular(25)),
                            ),
                            child: const Center(
                              child: Text(
                                'Login',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 21,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 40),
                        // Sign Up Navigation
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              const Text(
                                "Don't have an account?",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.grey,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => RegisterPage(),
                                    ),
                                  );
                                },
                                child: const Text(
                                  "Sign up",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}