

import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../model/Profile.dart';

class UserProfileSearch extends StatefulWidget {
  Profile? profile;
  UserProfileSearch({super.key, this.profile});
  @override
  _UserProfileSearch createState() => _UserProfileSearch();
}

class _UserProfileSearch extends State<UserProfileSearch>{
  @override
  Widget build(BuildContext context) {
    print(widget.profile);

    if (widget.profile!=null){
      return Container(
          height: 55.0,
          alignment: Alignment.centerLeft,
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
              Text(widget.profile!.username),
              TextButton(onPressed: (){}, child: const Icon(LucideIcons.plus))
            ],
          ));
    }
    else{
      return const Row(children: [Text("no user was found with this username")],);
    }

  }

}