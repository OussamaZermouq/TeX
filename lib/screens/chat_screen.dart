import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:chat_bubbles/chat_bubbles.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreen();
}

class _ChatScreen extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    final now = new DateTime.now();
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: EdgeInsets.all(15),
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
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: const Stack(
        children: [
      SingleChildScrollView(
      child: Column(
      children: <Widget>[

      BubbleSpecialThree(
        text: 'bubble special three without tail',
        color: Color(0xFF1B97F3),
        tail: true,
        textStyle: TextStyle(color: Colors.white, fontSize: 16),
      ),
      BubbleSpecialThree(
        text: 'bubble special three with tail',
        color: Color(0xFF1B97F3),
        tail: true,
        textStyle: TextStyle(color: Colors.white, fontSize: 16),
      ),
      BubbleSpecialThree(
        text: "bubble special three without tail",
        color: Color(0xFFE8E8EE),
        tail: true,
        isSender: false,
      ),
      BubbleSpecialThree(
        text: "bubble special three with tail",
        color: Color(0xFFE8E8EE),
        tail: true,
        isSender: false,
      ),
      SizedBox(
        height: 100,
      )
      ],
    ),
    )]),
    bottomNavigationBar: Padding(
    padding: const EdgeInsets.only(left: 20, bottom: 10, right:20, top: 0),
    child: Row(
    children: [
    Expanded(
    child: TextField(
    decoration: InputDecoration(
    border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(30.0)
    ),
    ))
    ),
    IconButton(onPressed: (){}, icon: Icon(Icons.send_rounded)),
    ]
    )
    )
    ,
    );
  }
}
