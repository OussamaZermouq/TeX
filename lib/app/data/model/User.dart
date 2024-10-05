import 'package:uuid/uuid.dart';

class User {
  String userId;
  String username;
  String email;
  String password;

  User({
    required this.userId,
    required this.email,
    required this.username,
    required this.password,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['userId'],
      username: json['username'],
      email: json['email'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'username': username,
      'email': email,
      'password': password,
    };
  }
  
}
