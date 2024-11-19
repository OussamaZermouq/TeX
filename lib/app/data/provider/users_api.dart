import 'package:bcrypt/bcrypt.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/Profile.dart';
import '../model/User.dart';
import 'package:uuid/uuid.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UsersApi {
  static const String _baseUrl = "http://localhost:8080/api/v1/auth";
  static const String _baseUrlUser = "http://localhost:8080/api/v1/user";
  final secureStorage = const FlutterSecureStorage();


  Future<http.Response> register(
      {required String userId,
      required String email,
      required String password

      }) async {
    final headers = {
      'Content-Type': 'application/json',
    };
    final body = jsonEncode({
      'id': userId,
      'email': email,
      'password': password,
      'roles':[{
        'id':1
      }]
    });
    final response = await http.post(Uri.parse("$_baseUrl/register"),
        headers: headers, body: body);
    return response;
  }

  Future<http.Response> getContacts() async{
    final String? authToken = await secureStorage.read(key:"token");

    final headers = {
      'Content-Type': 'application/json',
      'Authorization':'Bearer ${authToken!}',
    };

    final response = await http.get(
      Uri.parse("$_baseUrlUser/contacts"),
      headers: headers,
    );

    return response;

  }


  Future<int> linkProfile({
    required String firstName,
    required String lastName,
    required String username,
    required int age,
    required String bio,
    required String imageURI,
  }) async {

    final String? authToken = await secureStorage.read(key:"token");
    final prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString("userId");

    const uuid = Uuid();
    final headers = {
      'Content-Type': 'application/json',
      'Authorization':'Bearer ${authToken!}',
    };
    final body = jsonEncode({
      'profileId': uuid.v6(),
      'firstName': firstName,
      'lastName': lastName,
      'username':username,
      'age': age,
      'imageURI': imageURI,

    });
    print(headers);
    final response = await http.post(
      Uri.parse("$_baseUrlUser/linkProfile?userId=$userId"),
      headers: headers,
      body: body,
    );
    return response.statusCode;
  }

  Future<http.Response> login({
    required String email,
    required String password,
}) async{
    final headers = {
      'Content-Type': 'application/json',
    };
    final body = jsonEncode({
      'email':email,
      'password':password,
    });
    final response = await http.post(
      Uri.parse("$_baseUrl/login"),
      headers: headers,
      body:body
    );
    return response;
  }
}
