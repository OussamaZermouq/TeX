import 'package:tex/app/data/model/Profile.dart';
import 'package:tex/app/data/provider/profile_api.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class ProfileService {
  final _api = ProfileApi();

  Future<Profile?> getProfileByUsername(username) async{
    http.Response response = await _api.getProfileUserByUsername(username: username);
    if (response.statusCode==200){
      return Profile.fromJson(jsonDecode(response.body));
    }
    return null;
  }

  Future<int> addContact(profileId) async{
    http.Response response = await _api.addContact(profileId:profileId);
    return response.statusCode;
  }
}
