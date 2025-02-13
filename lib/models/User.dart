class User {
  final int? id; // ✅ Make sure this exists!
  final String name;
  final String email;
  final String password;
  final String phoneNumber;

  User({
    this.id, // ✅ id is now optional
    required this.name,
    required this.email,
    required this.password,
    required this.phoneNumber,
  });

  // Convert JSON to User object
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'], // ✅ Ensure this is mapped correctly
      name: json['name'],
      email: json['email'],
      password: json['password'],
      phoneNumber: json['phoneNumber'],
    );
  }

  // Convert User object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id, // ✅ Ensure id is included
      'name': name,
      'email': email,
      'password': password,
      'phoneNumber': phoneNumber,
    };
  }
}
