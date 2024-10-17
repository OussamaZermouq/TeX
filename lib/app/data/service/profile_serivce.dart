import 'package:tex/app/data/model/Profile.dart';
import 'package:tex/app/data/provider/profile_api.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class ProfileSerivce {
  final _api = ProfileApi();
  Future<int> createProfile(
      firstName, lastName, age, bio, imageURI, userId) async {
    return _api.createProfile(
        firstName: firstName,
        lastName: lastName,
        age: age,
        bio: bio,
        imageURI: imageURI,
        userId: userId);
  }

  Future<Profile?> getProfileByUsername(username) async{
    http.Response response = await _api.getProfileUserByUsername(username: username);
    if (response.statusCode==200){
      return Profile.fromJson(jsonDecode(response.body));
    }
    return null;
  }

}
