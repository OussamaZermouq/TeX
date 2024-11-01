

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:tex/app/data/service/profile_serivce.dart';
import '../model/Profile.dart';

class UserProfileSearch extends StatefulWidget {
  Profile? profile;
  UserProfileSearch({super.key, this.profile});
  @override
  _UserProfileSearch createState() => _UserProfileSearch();
}
class _UserProfileSearch extends State<UserProfileSearch>{

  Future<void> addContact() async {
    final profileService = ProfileService();
    int statusCode = await profileService.addContact(widget.profile!.profileId);
    print(statusCode);
  }

  @override
  Widget build(BuildContext context) {
    print(widget.profile);
    if (widget.profile!=null){
      return Container(
          height: 55.0,
          alignment: Alignment.center,
          child: Row(
            children: <Widget>[
              Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: CircleAvatar(
                    child: ClipOval(
                      child: Image.network(
                        widget.profile!.imageURI,
                        fit: BoxFit.cover,
                        height: 100,
                        width: 100,
                      ),
                    ),
                  ),
              ),
              const SizedBox(width: 20),
              Text(widget.profile!.username),
              const SizedBox(width: 50),
              TextButton(onPressed: (){
                addContact();
              }, child: const Icon(LucideIcons.plus))
            ],
          ));
    }
    else{
      return const Row(children: [Text("no user was found with that username")],);
    }

  }

}