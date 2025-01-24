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
  static Future<String> registerUser(User user) async {  
    try {  
      final response = await _dio.post(  
        '$baseUrl/register',  
        data: user.toJson(),  
        options: Options(headers: {'Content-Type': 'application/json'}),  
      );  

      if (response.statusCode == 201) {  
        return response.data['message'] ?? "Registration successful!";  
      } else if (response.statusCode == 400 || response.statusCode == 422) {  
        return response.data['error'] ?? "Invalid data provided.";  
      } else {  
        return "Registration failed. Please try again.";  
      }  
    } catch (e) {  
      return "An error occurred. Please check your internet connection.";  
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
        options: Options(headers: {'Content-Type': 'application/json'}),  
      );  

      if (response.statusCode == 200) {  
        // Store the token after successful login  
        _token = response.data['token']; // Assuming the token is in the 'token' key  
        print("Login successful. Token saved: $_token");  
        return response.data['message'] ?? "Login successful!";  
      } else if (response.statusCode == 401) {  
        return response.data['error'] ?? "Invalid email or password.";  
      } else {  
        return "Login failed. Please try again.";  
      }  
    } catch (e) {  
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
}