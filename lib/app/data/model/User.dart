
class User {
  String userId;
  String email;
  String? password;

  User({
    required this.userId,
    required this.email,
    this.password,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    print(json);
    return User(
      userId: json['id'],
      email: json['email'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'email': email,
      'password': password,
    };
  }
  
}
