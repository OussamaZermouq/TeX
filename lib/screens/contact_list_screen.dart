import 'package:flutter/material.dart';
import 'package:tex/app/data/CustomWidgets/ContactProfile.dart';
import 'package:tex/app/data/CustomWidgets/UserProfileSearch.dart';
import 'package:tex/app/data/model/Profile.dart';
import 'package:tex/app/data/service/profile_serivce.dart';
import 'package:tex/app/data/service/user_service.dart';

class ContactListScreen extends StatefulWidget {
  const ContactListScreen({super.key});

  @override
  State<ContactListScreen> createState() => _ContactListScreen();
}

//TODO : move the modal to a separate class as a custom widget
class _ContactListScreen extends State<ContactListScreen> {
  Profile? userProfile;
  final TextEditingController _usernameController = TextEditingController();
  List<Profile>? contacts;
  final profileService = ProfileService();
  final userService = UserService();

  @override
  void initState() {
    super.initState();
    getContacts();
  }
  Future<List<Profile>?> getContacts() async {

    List<Profile>? contacts_ = await userService.getContacts();
    if (contacts_ != null && contacts == null) {
      contacts = contacts_;
    }
    return contacts_;
  }

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
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.add),
              tooltip: 'Add Contacts',
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
            ),
          ],
        ),
        body: FutureBuilder(
          future: getContacts(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount:contacts!.length,
                  itemBuilder: (context, index) {
                return Card(
                      child: ListTile(
                        leading: CircleAvatar(
                            child: ClipOval(
                              child: Image.network(
                                contacts![index].imageURI,
                                fit: BoxFit.cover,
                                height: 100,
                                width: 100,
                              ),
                            )
                        ),
                        title: Text(contacts![index].username),
                        subtitle: contacts![index].bio != null && contacts![index].bio!.isNotEmpty
                            ? Text(contacts![index].bio!)
                            : const Text("Hey I'm using TeX!", style: TextStyle(fontStyle: FontStyle.italic),),
                        trailing: IconButton(
                          icon: const Icon(Icons.message),
                          onPressed: (){},
                        ),
                      ),
                  );
              });
            } else if (snapshot.hasError) {
              print(snapshot.error);
              return const Text("ERROR");
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ));
  }
}
