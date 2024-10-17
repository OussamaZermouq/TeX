

import 'package:flutter/material.dart';

import '../model/Profile.dart';

class UserProfileSearch extends StatelessWidget{
  Profile? profile;
  UserProfileSearch({super.key, this.profile});

  @override
  Widget build(BuildContext context) {
    if (profile!=null){
      return Container(
          height: 55.0,
          alignment: Alignment.centerLeft,
          child: Row(
            children: <Widget>[
              Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30.0),
                    child: const Image(
                        image: AssetImage(
                            'assets/images/userimage.jpg')
                    ),
                  )
              ),
              Text(profile!.username),
              ElevatedButton(onPressed: (){}, child: const Text("Add Contact"))
            ],
          ));
    }
    else{
      return Row(children: [const Text("no user was found with this username")],);
    }
    
  }

}