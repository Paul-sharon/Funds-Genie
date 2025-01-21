import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'http://10.0.2.2:8093/gtl-ws/api'; // Replace with your server's URL

  // User registration API call
  static Future<String> registerUser(String name, String email, String password) async {
    final url = Uri.parse('$baseUrl/register');
    final body = jsonEncode({
      'name': name,
      'email': email,
      'password': password,
    });

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: body,
      );

      if (response.statusCode == 201) {
        return "Registration successful!";
      } else if (response.statusCode == 400) {
        return "Validation error: ${jsonDecode(response.body)['message']}";
      } else {
        return "Registration failed. Try again.";
      }
    } catch (e) {
      return "An error occurred: $e";
    }
  }
}
