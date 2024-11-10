


import 'package:flutter/material.dart';

import '../model/Profile.dart';


class Contactprofile extends StatefulWidget{
  Profile? profile;
  Contactprofile({super.key, this.profile});
  @override
  _ContactProfile createState() => _ContactProfile();
}

class _ContactProfile extends State<Contactprofile>{
  void MessageContact(){

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55.0,
      alignment: Alignment.center,
      child: Row(
        children: [
          Padding(padding: const EdgeInsets.all(5.0),
          child: CircleAvatar(
            child: ClipOval(
              child: Image.network(
                widget.profile!.imageURI,
                height: 100,
                width: 100,
              ),
            )
          ),),

        ],
      ),
    );
  }

}
