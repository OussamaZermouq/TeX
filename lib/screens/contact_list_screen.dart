import 'package:flutter/material.dart';
import 'package:tex/app/data/CustomWidgets/UserProfileSearch.dart';
import 'package:tex/app/data/model/Profile.dart';
import 'package:tex/app/data/service/profile_serivce.dart';

class ContactListScreen extends StatefulWidget {
  const ContactListScreen({super.key});

  @override
  State<ContactListScreen> createState() => _ContactListScreen();
}

class _ContactListScreen extends State<ContactListScreen> {
  Profile? userProfile;
  final TextEditingController _usernameController = TextEditingController();
  final profileService = ProfileService();

  Future<void> findContact(String username) async {
    Profile? profile = await profileService.getProfileByUsername(username);

    setState(() {
      userProfile = profile;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contacts'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Center(
            child: Text(
              'You have no contacts',
              style: TextStyle(fontSize: 24),
            ),
          ),
          ElevatedButton(
            onPressed: () => showModalBottomSheet(
              context: context,
              builder: (context) => StatefulBuilder(
                builder: (context, setModalState) {
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        TextField(
                          controller: _usernameController,
                          decoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: "Search by username",
                          ),
                          onChanged: (username) async {
                            if (username.isNotEmpty) {
                              try {
                                await findContact(username);
                                setModalState(() {});
                              } catch (error) {
                                print("ERROR");
                                print(error);
                              }
                            }
                          },
                        ),
                        const SizedBox(height: 16),
                        UserProfileSearch(profile: userProfile),
                      ],
                    ),
                  );
                },
              ),
            ),
            child: const Text('Add contacts'),
          ),
        ],
      ),
    );
  }
}
