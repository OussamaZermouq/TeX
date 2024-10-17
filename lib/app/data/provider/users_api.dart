import 'package:bcrypt/bcrypt.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/User.dart';
import 'package:uuid/uuid.dart';

class UsersApi {
  static const String _baseUrl = "http://localhost:8080/api/v1/user";
  Future<int> createUser(
      {required String userId,
      required String email,
      required String username,
      required String password}) async {
    final headers = {
      'Content-Type': 'application/json',
    };
    final body = jsonEncode({
      'id': userId,
      'email': email,
      'username': username,
      'password': BCrypt.hashpw(password, BCrypt.gensalt()),
    });
    final response = await http.post(Uri.parse("$_baseUrl/add"),
        headers: headers, body: body);
    return response.statusCode;
  }
}
