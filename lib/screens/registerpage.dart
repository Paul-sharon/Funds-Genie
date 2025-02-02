import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/user.dart'; // Import the User model
import 'loginpage.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  // Validate and Register User
  void _register() async {
    if (_formKey.currentState!.validate()) {
      final String name = _nameController.text.trim();
      final String email = _emailController.text.trim();
      final String password = _passwordController.text.trim();
      final String phoneNumber = _phoneController.text.trim();

      // Create a User object
      final user = User(
        name: name,
        email: email,
        password: password,
        phoneNumber: phoneNumber,
      );

      // API call
      final result = await ApiService.registerUser(user);

      // Show response message in SnackBar
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(result)));

      // Navigate to LoginPage on success
      if (result.contains("successful")) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
        );
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFFFFD700), // Bright Gold (left)
                  Color(0xFFDAA520), // Slightly lighter Dark Goldenrod (middle)
                  Color(0xFF8B6A3B), // Darker Golden (right)
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
            child: const Padding(
              padding: EdgeInsets.only(top: 60.0, left: 22),
              child: Text(
                'Create Your\nAccount!',
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
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
                        Center(
                          child: Image.asset(
                            'assets/Genie.png',  // Make sure this file exists in your assets folder
                            width: 150,  // Adjust size as needed
                            height: 170,
                            fit: BoxFit.contain,
                          ),
                        ),
                        // Full Name TextField
                        TextFormField(
                          controller: _nameController,
                          style: const TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            labelText: "Full Name", // Label above input field
                            labelStyle: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black, // Custom red label color
                            ),
                            hintText: "Enter your full name",
                            hintStyle: const TextStyle(
                              color: Colors.grey, // Light gray hint text
                            ),
                            filled: true,
                            fillColor: Colors.white, // White background
                            suffixIcon: const Icon(
                              Icons.check,
                              color: Colors.grey, // Check icon at the end
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12), // Rounded corners
                              borderSide: BorderSide(
                                color: Colors.grey.shade300, // Light gray border
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: Colors.grey.shade400, // Border color when enabled
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
                              return "Name cannot be empty."; // Validation for empty name
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          controller: _emailController,
                          style: const TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            labelText: "Email", // Label above input field
                            labelStyle: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black, // Custom red color for the label
                            ),
                            hintText: "Enter your email",
                            hintStyle: const TextStyle(
                              color: Colors.grey, // Light gray hint text
                            ),
                            filled: true,
                            fillColor: Colors.white, // White background for the text field
                            suffixIcon: const Icon(
                              Icons.check, // Check icon at the end
                              color: Colors.grey,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12), // Rounded corners for the border
                              borderSide: BorderSide(
                                color: Colors.grey.shade300, // Light gray border color
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: Colors.grey.shade400, // Border color when enabled
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
                            if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                              return "Enter a valid email address.";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 10),
                        // Password TextField
                        TextFormField(
                          controller: _passwordController,
                          obscureText: !_isPasswordVisible,
                          style: const TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            labelText: "Password", // Label above input field
                            labelStyle: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black, // Custom red color for the label
                            ),
                            hintText: "Enter your password",
                            hintStyle: const TextStyle(
                              color: Colors.grey, // Light gray hint text
                            ),
                            filled: true,
                            fillColor: Colors.white, // White background for the text field
                            suffixIcon: IconButton(
                              icon: Icon(
                                _isPasswordVisible ? Icons.visibility : Icons.visibility_off, // Toggle icon visibility
                                color: Colors.grey,
                              ),
                              onPressed: () {
                                setState(() {
                                  _isPasswordVisible = !_isPasswordVisible;
                                });
                              },
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12), // Rounded corners for the border
                              borderSide: BorderSide(
                                color: Colors.grey.shade300, // Light gray border color
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: Colors.grey.shade400, // Border color when enabled
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
                            if (value == null || value.length < 6) {
                              return "Password must be at least 6 characters.";
                            }
                            return null;
                          },
                        ),
                        // Confirm Password TextField
                        const SizedBox(height: 10),
                        TextFormField(
                          controller: _confirmPasswordController,
                          obscureText: !_isConfirmPasswordVisible,
                          style: const TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            labelText: "Confirm Password", // Label above input field
                            labelStyle: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black, // Custom red color for the label
                            ),
                            hintText: "Re-enter your password",
                            hintStyle: const TextStyle(
                              color: Colors.grey, // Light gray hint text
                            ),
                            filled: true,
                            fillColor: Colors.white, // White background for the text field
                            suffixIcon: IconButton(
                              icon: Icon(
                                _isConfirmPasswordVisible ? Icons.visibility : Icons.visibility_off, // Toggle icon visibility
                                color: Colors.grey,
                              ),
                              onPressed: () {
                                setState(() {
                                  _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                                });
                              },
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12), // Rounded corners for the border
                              borderSide: BorderSide(
                                color: Colors.grey.shade300, // Light gray border color
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: Colors.grey.shade400, // Border color when enabled
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
                            if (value != _passwordController.text) {
                              return "Passwords do not match."; // Validation for matching passwords
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          //controller: _phoneNumberController,
                          style: const TextStyle(color: Colors.black),
                          keyboardType: TextInputType.phone, // Ensures the keyboard is suited for phone numbers
                          decoration: InputDecoration(
                            labelText: "Phone Number", // Label above input field
                            labelStyle: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black, // Custom red color for the label
                            ),
                            hintText: "Enter your phone number",
                            hintStyle: const TextStyle(
                              color: Colors.grey, // Light gray hint text
                            ),
                            filled: true,
                            fillColor: Colors.white, // White background for the text field
                            prefixText: "+91 ", // Prefix the country code
                            prefixStyle: const TextStyle(
                              color: Colors.black, // Color for the prefix
                              fontWeight: FontWeight.bold,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12), // Rounded corners for the border
                              borderSide: BorderSide(
                                color: Colors.grey.shade300, // Light gray border color
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: Colors.grey.shade400, // Border color when enabled
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
                              return "Phone number cannot be empty.";
                            }

                            // Updated regex to accept both formats
                            if (!RegExp(r'^(?:\+91\s?\d{10}|\d{10})$').hasMatch(value)) {
                              return "Please enter a valid phone number (10 digits or +91 followed by 10 digits).";
                            }

                            return null; // Return null if the validation passes
                          },
                        ),
                        const SizedBox(height: 30),
                        GestureDetector(
                          onTap: _register,
                          child: Container(
                            height: 55,
                            width: 370,
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Color(0xFFFFD700), // Bright Gold (left)
                                  Color(0xFFDAA520), // Slightly lighter Dark Goldenrod (middle)
                                  Color(0xFF8B6A3B), // Darker Golden (right)
                                ],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ),
                              borderRadius: BorderRadius.all(Radius.circular(25)),
                            ),
                            child: const Center(
                              child: Text(
                                'SIGN UP',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                        // Sign Up Navigation
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              const Text(
                                "Already have account?",
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
                                      builder: (context) => LoginPage(),
                                    ),
                                  );
                                },
                                child: const Text(
                                  "Sign in",
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
