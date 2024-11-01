import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tex/app/data/model/Profile.dart';
import 'package:tex/app/data/model/User.dart';
import 'package:uuid/uuid.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
class ProfileApi {
  static const String _baseUrl = 'http://localhost:8080/api/v1/profile';
  final storage = const FlutterSecureStorage();
  //creates and links a profile to the previously registered user

  Future<http.Response> getProfileUserByUsername({
    required String username
  }) async{
    final String? token = await storage.read(key:'token');
    final headers = {
      'Content-Type': 'application/json',
      'Authorization':'Bearer ${token}'
    };
    final response = await http.get(
      Uri.parse("$_baseUrl/username?username=$username"),
      headers: headers,
    );
    return response;
  }

  Future<http.Response> addContact({required String profileId}) async {
    final prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString("userId");
    final String? token = await storage.read(key: 'token');

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final body = {
      "profileID": profileId
    };

    print("$_baseUrl/addContact?userId=$userId");

    final response = await http.post(
      Uri.parse("$_baseUrl/addContact?userId=$userId"),
      headers: headers,
      body: jsonEncode(body),  // Encode body to JSON
    );

    return response;
  }

}
