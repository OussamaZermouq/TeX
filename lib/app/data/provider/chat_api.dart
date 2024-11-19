


import 'dart:math';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:tex/app/data/model/Chat.dart';

import '../model/Profile.dart';

class ChatApi{
  static const String _baseUrl = "http://localhost:8080/api/v1/chat";

  final secureStorage = const FlutterSecureStorage();
  Future<http.Response> createChat(String profileUUIDToChatWith) async{
    final String? authToken = await secureStorage.read(key: "token");

    final headers = {
      'Authorization' : 'Bearer ${authToken!}',
    };
    final body = {
      'profileID' : profileUUIDToChatWith
    };

    final response = await http.post(
      Uri.parse("$_baseUrl/create"),
      headers: headers,
      body:body,
    );

    return response;
  }

  Future<http.Response> getChats() async{
    final String? authToken = await secureStorage.read(key: "token");
    final headers = {
      'Authorization' : 'Bearer ${authToken!}',
    };
    final response = await http.get(
      Uri.parse("$_baseUrl/"),
      headers: headers,
    );
    return response;
  }
}