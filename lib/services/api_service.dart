import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user.dart';

class ApiService {
  static const String baseUrl = "http://10.0.2.2:8093/gtl-ws/api";

  // Register User
  static Future<String> registerUser(User user) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/register'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(user.toJson()),
      );

      print('Response body: ${response.body}');
      print('Response status code: ${response.statusCode}');

      if (response.statusCode == 201) {
        final data = jsonDecode(response.body);
        return data['message'] ?? "Registration successful!";
      } else if (response.statusCode == 400 || response.statusCode == 422) {
        final data = jsonDecode(response.body);
        return data['error'] ?? "Invalid data provided.";
      } else {
        return "Registration failed. Please try again.";
      }
    } catch (e) {
      print("Error: $e");
      return "An error occurred. Please check your internet connection.";
    }
  }

  // Login User
  static Future<String> loginUser(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );

      // Log the response body
      print('Response body: ${response.body}');

      // Check if the response is a valid JSON object
      try {
        final data = jsonDecode(response.body);
        return data['message'] ?? "Login successful!";
      } catch (e) {
        // If response body is not JSON, treat it as a plain string
        return response.body ?? "An error occurred.";
      }
    } catch (e) {
      print("Error: $e");
      return "An error occurred. Please check your internet connection.";
    }
  }
}
