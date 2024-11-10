import 'dart:convert';

import 'package:tex/app/data/model/User.dart';

//i probably should move this to a helper class instead of keeping it here :|
List<Profile> profilesFromJson(String profileList) => List<Profile>.from(jsonDecode(profileList).map((profile)=>Profile.fromJson(profile)));


class Profile {
  String profileId;
  String firstName;
  String lastName;
  int age;
  String? bio;
  String imageURI;
  String username;

  Profile({
    required this.profileId,
    required this.firstName,
    required this.lastName,
    required this.age,
    this.bio,
    required this.imageURI,
    required this.username,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
        profileId: json['profileId'],
        firstName: json['firstName'],
        lastName: json['lastName'],
        username: json['username'],
        age: json['age'],
        bio: json['bio'],
        imageURI: json['imageURI']);
  }

  Map<String, dynamic> toJson() {
    return {
      'profileId': profileId,
      'firstName': firstName,
      'lastName': lastName,
      'username':username,
      'age': age,
      'bio': bio,
      'imageURI': imageURI,
    };
  }

}
