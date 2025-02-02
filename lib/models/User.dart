class User {
  final String name;
  final String email;
  final String password;
  final String phoneNumber; // Add phone number

  User({
    required this.name,
    required this.email,
    required this.password,
    required this.phoneNumber,
  });

  // Convert JSON to User object
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'],
      email: json['email'],
      password: json['password'],
      phoneNumber: json['phoneNumber'],
    );
  }

  // Convert User object to JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'phoneNumber': phoneNumber,
    };
  }
}
