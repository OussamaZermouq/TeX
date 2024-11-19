import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../model/Chat.dart';
import '../model/Profile.dart';

class ChatWidget extends StatefulWidget {
  Chat? chat;

  ChatWidget({super.key, this.chat});

  @override
  _ChatWidget createState() => _ChatWidget();
}

class _ChatWidget extends State<ChatWidget> {
  void enterChat() {}

  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: GestureDetector(
          onTap: () {

            },
          child: Container(
            height: 60.0,
            alignment: Alignment.centerLeft,
            child: Row(
              children: <Widget>[
                Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: CircleAvatar(
                        child: ClipOval(
                          child: Image.network(
                            widget.chat!.members[0].imageURI,
                            fit: BoxFit.cover,
                            height: 100,
                            width: 100,
                          ),
                        )
                    )),
                Column(
                  children: <Widget>[
                    Text(
                      widget.chat!.members[0].username,
                      style: TextStyle(fontSize: 20),
                    ),
                    Text(
                      'Tap to chat',
                      style:
                          TextStyle(fontStyle: FontStyle.italic, fontSize: 15),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
