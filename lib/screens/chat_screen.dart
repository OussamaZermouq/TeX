import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:stomp_dart_client/stomp_dart_client.dart';
import 'package:tex/app/data/model/Message.dart';
import 'package:uuid/v6.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
class ChatScreen extends StatefulWidget {
  StompClient stompClient;
  ChatScreen({super.key, required this.stompClient});

  //should expect a list of chats as a class member
  @override
  State<ChatScreen> createState() => _ChatScreen();
}

class _ChatScreen extends State<ChatScreen> {


  List<Widget> messageBubbles = [];
  late String? userId;

  final chatController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.stompClient.subscribe(
      destination: '/topic/chat/0294c2dc-30b0-4123-ae32-28718a654358',
      callback: (StompFrame frame) {
        _handleIncomingMessage(frame);
      },
    );
    SharedPreferences.getInstance().then((onValue) => userId = onValue.getString('userId'));

  }
  void sendMessage(String message){

    if (message.isNotEmpty){
      widget.stompClient.send(
          destination: "/app/chat/0294c2dc-30b0-4123-ae32-28718a654358",
          body: jsonEncode(Message(
              messageId: const UuidV6().generate(),
              content: message,
              createdAt: DateTime.now().toLocal(),
              senderId: userId!).toJson()
      ));
    }
  }
  void _handleIncomingMessage(StompFrame frame) {
    if (frame.body != null) {
      try {
        Message receivedMessage = Message.fromJson(jsonDecode(frame.body!));
        if (receivedMessage.senderId!=userId) {
          setState(() {
            messageBubbles.add(BubbleSpecialThree(
              text: receivedMessage.content,
              isSender: false,
            ));
          });
        }
      } catch (e) {
        print('Error processing message: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Stack(
          alignment: Alignment.center,
          children: [
            Center(
            child:Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: EdgeInsets.all(5),
                  child: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    child: ClipOval(
                      child: FlutterLogo(
                        size: 20,
                      ),
                    ),
                  ),
                ),
                Text(
                  "redaAroui",
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
            )

        ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  for (Widget message in messageBubbles)
                    DynamicItemWidget(
                      data: message,
                      onDelete: () {
                        setState(() {
                        });
                      },
                    ),
                ],
              ),
            )
          ]),
      bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(
              left: 20, bottom: 10, right: 20, top: 0),
          child: Row(
              children: [
                Expanded(
                    child: TextField(
                      controller: chatController,
                        maxLines: 4,
                        minLines: 1,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0)
                          ),
                        ))
                ),
                IconButton(onPressed: () {
                  if (chatController.text.isNotEmpty) {
                    sendMessage(chatController.text);
                    setState(() {
                      messageBubbles.add(
                        BubbleSpecialThree(
                          text: chatController.text,
                          color: const Color(0xFF1B97F3),
                          tail: true,
                          textStyle: const TextStyle(color: Colors.white,
                              fontSize: 16),
                        ),
                      );
                    }
                  );
                  chatController.text = "";
                }
                  },
              icon: const Icon(Icons.send_rounded)),
              ]
          )
      )
      ,
    );
  }
}


class DynamicItemWidget extends StatelessWidget {
  final Widget data;
  final VoidCallback onDelete;

  const DynamicItemWidget({required this.data, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: data,
    );
  }
}
