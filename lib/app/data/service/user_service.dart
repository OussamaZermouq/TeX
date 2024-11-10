import 'dart:convert';

import 'package:http/http.dart';
import 'package:uuid/uuid.dart';

import '../model/Profile.dart';
import '../provider/users_api.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
class UserService {
  final secureStorage = const FlutterSecureStorage();
  final _api = UsersApi();

  Future<int> linkProfile(
      firstName, lastName, username, age, bio, imageURI) async {
    return _api.linkProfile(
      firstName: firstName,
      lastName: lastName,
      username:username,
      age: age,
      bio: bio,
      imageURI: imageURI,
    );
  }

  Future<int> createUser(userId,email, password) async {

    Response res = await _api.register(
        userId:userId,
        email: email,
        password: password,
    );
    Map<String, dynamic> responseJson = jsonDecode(res.body);

    if (res.statusCode==200){
      await secureStorage.write(
        key: "token",
        value: responseJson['accessToken']
      );
    }

    return res.statusCode;
  }
  Future<int> login(email, password) async{
    Response res = await _api.login(email: email, password: password);
    Map<String, dynamic> responseJson = jsonDecode(res.body);

    if (res.statusCode==200){
      await secureStorage.write(
          key: "token",
          value: responseJson['accessToken']
      );
    }
    return res.statusCode;
  }

  Future<List<Profile>?> getContacts() async{
    Response res = await _api.getContacts();
    if (res.statusCode==202){
      List<Profile> contacts = profilesFromJson(res.body);
      return contacts;
    }
    return null;
  }
}
