import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:cookie_jar/cookie_jar.dart';
import '../models/user.dart'; // Ensure consistent import of User model

class ApiService {
  static const String baseUrl = "http://10.0.2.2:8093/gtl-ws/api";
  static String? _token; // Store the token
  // Dio instance with cookie management
  static final Dio _dio = Dio()
    ..interceptors.add(CookieManager(CookieJar())); // Attach CookieManager
  // Register User
  static Future<String> registerUser(User user) async {
    try {
      final response = await _dio.post(
        '$baseUrl/register',
        data: user.toJson(),
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );

      if (response.statusCode == 201) {
        return response.data['message'] ?? "Registration successful!";
      } else if (response.statusCode == 400 || response.statusCode == 422) {
        return response.data['error'] ?? "Invalid data provided.";
      } else {
        return "Registration failed. Please try again.";
      }
    } catch (e) {
      return "Email is already registered.";
    }
  }

  // Login User
  static Future<String> loginUser(String email, String password) async {
    try {
      final response = await _dio.post(
        '$baseUrl/login',
        data: {
          'email': email,
          'password': password,
        },
        options: Options(
          headers: {'Content-Type': 'application/json'},
          validateStatus: (status) => status! < 500, // Allow 401 to be processed //By default, Dio treats status codes from 200 to 299 as successful.
        ),
      );

      if (response.statusCode == 200) {
        // Store the token after a successful login
        _token = response.data['token'];

        print("Login successful. Token saved: $_token");
        return response.data['message'] ?? "Login successful!";
      } else if (response.statusCode == 401) {
        return response.data['error'] ?? "Invalid email or password.";
      } else {
        return "Login failed. Please try again.";
      }
    } catch (e) {
      // Log the error for debugging purposes
      print("Error during login: $e");
      return "An error occurred. Please check your internet connection.";
    }
  }

  // Fetch Current User Details
  static Future<User?> fetchCurrentUser() async {
    if (_token == null) {
      print("No token available. Please log in first.");
      return null; // Token is null, return early
    }

    try {
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $_token', // Correct syntax for Bearer token
      };

      final response = await _dio.get(
        '$baseUrl/currentUser',
        options: Options(headers: headers),
      );

      if (response.statusCode == 200) {
        final data = response.data;

        // Debug: Log the response data
        print("Current user data: $data");

        // Extract the 'user' object from the response data
        if (data != null && data['user'] != null) {
          final userData = data['user'];

          // Now create the User object from the 'user' data
          return User.fromJson(userData); // Assuming the 'User' class can handle this data
        } else {
          print("Invalid user data: $data");
          return null;
        }
      } else if (response.statusCode == 401) {
        print("Unauthorized: ${response.data}");
        return null;
      } else {
        print("Unexpected error: ${response.data}");
        return null;
      }
    } catch (e) {
      print("Exception during fetchCurrentUser: $e");
      return null;
    }
  }

  static Future<String> logoutUser() async {
    try {
      final response = await _dio.post(
        '$baseUrl/logout', // Your logout endpoint
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $_token', // Add the token for authentication
          },
        ),
      );

      if (response.statusCode == 200) {
        // Clear token or session data if needed
        _token = null;
        print("Logout successful.");
        return response.data['message'] ?? "Logout successful!";
      } else {
        print("Logout failed with status code: ${response.statusCode}");
        return response.data['error'] ?? "Logout failed. Please try again.";
      }
    } catch (e) {
      // Handle network or other unexpected errors
      print("Error in logoutUser: $e");
      return "An error occurred. Please check your internet connection.";
    }
  }
  static Future<List<Map<String, dynamic>>> getInvestments() async {
    try {
      final response = await _dio.get(
        '$baseUrl/investments',
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );

      if (response.statusCode == 200 && response.data != null) {
        print("Investments fetched successfully.");

        // Ensure all values inside the list are non-null
        return List<Map<String, dynamic>>.from(
          (response.data as List).map((item) => item ?? {}).toList(),
        );
      } else {
        print("Failed to fetch investments: ${response.data}");
        return [];
      }
    } catch (e) {
      print("Error fetching investments: $e");
      return [];
    }
  }
  static Future<List<Map<String, dynamic>>> getTransactions() async {
    try {
      User? currentUser = await fetchCurrentUser();

      if (currentUser == null) {
        print("User not logged in.");
        return [];
      }

      // ✅ Check if id is null
      if (currentUser.id == null) {
        print("User ID is missing!");
        return [];
      }

      String userId = currentUser.id!.toString();
      print("Current User ID: $userId");

      final response = await _dio.get(
        '$baseUrl/transactions',
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );

      if (response.statusCode == 200 && response.data != null) {
        print("Transactions fetched successfully.");
        return List<Map<String, dynamic>>.from(response.data as List);
      } else {
        print("Failed to fetch transactions: ${response.data}");
        return [];
      }
    } catch (e) {
      print("Error fetching transactions: $e");
      return [];
    }
  }



}
