import 'package:flutter/material.dart';
import 'package:tex/app/data/CustomWidgets/UserProfileSearch.dart';
import 'package:tex/app/data/model/Profile.dart';
import 'package:tex/app/data/service/profile_serivce.dart';

class ContactListScreen extends StatefulWidget{
  const ContactListScreen({super.key});

  @override
  State<ContactListScreen> createState() => _ContactListScreen();
}

class _ContactListScreen extends State<ContactListScreen> {
  Profile? userProfile;
  Future<void> findContact() async{
      final profileService = ProfileSerivce();
      Profile? profile = await profileService.getProfileByUsername("redaAroui");
      if (profile!=null){
        setState(() {
          userProfile = profile;
        });
      }
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contacts'),
      ),
      body:
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                 Center(
                  child: Text(
                    'You have no contacts',
                    style: TextStyle(fontSize: 24),
                  ),
                ),
                ElevatedButton(
                  onPressed: () => showModalBottomSheet(
                    context: context,
                    builder: (context) => Container(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max, // This will adjust the height based on content
                        children: [
                          TextField(
                            decoration: InputDecoration(
                              border: UnderlineInputBorder(),
                              labelText: "Search by username",
                            ),
                          ),
                          UserProfileSearch(profile: userProfile,),
                          ElevatedButton(onPressed: (){
                            findContact();
                          }, child: const Text("Search"))
                        ],
                      ),
                    ),
                  ),
                  child: const Text('Add contacts'),
                )
              ],
            ),
    );
  }
}