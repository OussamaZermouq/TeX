import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stomp_dart_client/stomp_dart_client.dart';
import 'package:tex/screens/chat_screen.dart';

import '../model/Chat.dart';
import '../model/Profile.dart';

class ChatWidget extends StatefulWidget {
  Chat? chat;
  StompClient client;
  ChatWidget({super.key, this.chat, required this.client});

  @override
  _ChatWidget createState() => _ChatWidget();
}

class _ChatWidget extends State<ChatWidget> {
  void enterChat() {

    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
          ChatScreen(stompClient: widget.client)),
    );
  }

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
              enterChat();
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
                    const Text(
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
