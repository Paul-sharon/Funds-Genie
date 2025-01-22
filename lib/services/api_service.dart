import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "http://10.0.2.2:8093/gtl-ws/api";

  // Fetch current user details
  static Future<Map<String, dynamic>?> fetchCurrentUser() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/currentUser'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return null; // Return null if unauthorized or not found
      }
    } catch (e) {
      print("Error fetching current user: $e");
      return null;
    }
  }

  // Register User
  static Future<String> registerUser(String name, String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/register'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'name': name,
          'email': email,
          'password': password,
        }),
      );

      print('Response body: ${response.body}');
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['message'] ?? "Registration successful!";
      } else {
        final data = jsonDecode(response.body);
        return data['error'] ?? "Registration failed. Please try again.";
      }
    } catch (e) {
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

      print('Response body: ${response.body}');
      try {
        final data = jsonDecode(response.body);
        return data['message'] ?? "Login successful!";
      } catch (e) {
        return response.body ?? "An error occurred.";
      }
    } catch (e) {
      print("Error: $e");
      return "An error occurred. Please check your internet connection.";
    }
  }
}
