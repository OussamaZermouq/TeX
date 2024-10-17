import 'package:flutter/cupertino.dart';
import 'package:tex/app/data/model/Profile.dart';
import 'package:tex/app/data/model/User.dart';
import 'package:uuid/uuid.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ProfileApi {
  static const String _baseUrl = 'http://localhost:8080/api/v1/profile';

  Future<int> createProfile({
    required String firstName,
    required String lastName,
    required int age,
    required String bio,
    required String imageURI,
    required String userId,
  }) async {
    const uuid = Uuid();
    final headers = {
      'Content-Type': 'application/json',
    };
    final body = jsonEncode({
      'profileId': uuid.v6(),
      'firstName': firstName,
      'lastName': lastName,
      'age': age,
      'imageURI': imageURI,
      'user': {
        'id': userId,
      }
    });
    final response = await http.post(
      Uri.parse("$_baseUrl/add"),
      headers: headers,
      body: body,
    );
    return response.statusCode;
  }

  Future<http.Response> getProfileUserByUsername({
    required String username
  }) async{
    final headers = {
      'Content-Type': 'application/json',
    };
    final response = await http.get(
      Uri.parse("$_baseUrl/username?username=$username"),
      headers: headers,
    );
    return response;
  }

}
