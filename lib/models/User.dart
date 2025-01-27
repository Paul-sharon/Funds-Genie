class User {
  final String name;
  final String email;
  final String password;
  final String? profileImage;  // This can be null or a base64 string

  User({
    required this.name,
    required this.email,
    required this.password,
    this.profileImage,  // Optional parameter for profile image
  });
  // Convert JSON to User object
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'],
      email: json['email'],
      password: json['password'],
      profileImage: json['profileImage'],  // Decode image
    );
  }

  // Convert User object to JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'profileImage': profileImage,  // Add image to JSON (null allowed)
    };
  }
}
