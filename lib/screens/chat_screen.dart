import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:stomp_dart_client/stomp_dart_client.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/v6.dart';

import '../app/data/model/Message.dart';
import '../app/data/model/User.dart';
import '../app/data/model/Chat.dart';
import '../app/data/service/chat_service.dart';

class ChatScreen extends StatefulWidget {
  final StompClient stompClient;
  final String chatId;

  const ChatScreen({Key? key, required this.chatId, required this.stompClient})
      : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List<Message> _messages = [];
  String? _currentUserId;
  final TextEditingController _chatController = TextEditingController();
  final ChatService _chatService = ChatService();
  bool _isLoading = true;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _initializeChat();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _chatController.dispose();
    super.dispose();
  }

  Future<void> _initializeChat() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _currentUserId = prefs.getString('userId');
    });

    // Subscribe to STOMP topic
    widget.stompClient.subscribe(
      destination: '/topic/chat/${widget.chatId}',
      callback: _handleIncomingMessage,
    );

    await _loadMessages();
  }

  Future<void> _loadMessages() async {
    try {
      setState(() {
        _isLoading = true;
      });

      // Fetch chat and its messages
      final Chat? chat = await _chatService.getChatById(widget.chatId);

      if (chat?.messages != null) {
        setState(() {
          _messages = chat!.messages!;
          _isLoading = false;
        });

        // Scroll to the bottom after loading messages
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (_scrollController.hasClients) {
            _scrollController.animateTo(
              _scrollController.position.maxScrollExtent,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut,
            );
          }
        });
      }
    } catch (e) {
      print('Error loading messages: $e');
      setState(() {
        _isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load messages: $e')),
      );
    }
  }

  void _handleIncomingMessage(StompFrame frame) {
    print("############INCOMING#################");
    print(frame.body);
    if (frame.body != null) {
      try {
        final receivedMessage = Message.fromJson(jsonDecode(frame.body!));

        if (receivedMessage.sender.userId != _currentUserId) {
          setState(() {
            _messages.add(receivedMessage);
          });
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (_scrollController.hasClients) {
              _scrollController.animateTo(
                _scrollController.position.maxScrollExtent,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOut,
              );
            }
          });
        }
      } catch (e) {
        print('Error processing incoming message: $e');
      }
    }
  }

  void _sendMessage() {
    final messageText = _chatController.text.trim();
    if (messageText.isNotEmpty && _currentUserId != null) {
      final message = Message(
        messageId: const UuidV6().generate(),
        content: messageText,
        senderId: _currentUserId!,
        sender: User(userId: _currentUserId!, email: ""),
        createdAt: DateTime.now().toLocal(),
      );

      widget.stompClient.send(
        destination: "/app/chat/${widget.chatId}",
        body: jsonEncode(message.toJson()),
      );
      setState(() {
        _messages.add(message);
        _chatController.clear();
      });

      // Scroll to bottom after sending
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_scrollController.hasClients) {
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text("Chat"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: Column(
        children: [
          // Loading indicator
          if (_isLoading) const LinearProgressIndicator(),
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                  child: BubbleSpecialThree(
                    text: message.content,
                    isSender: message.sender.userId == _currentUserId,
                    color: message.sender.userId == _currentUserId
                        ? Colors.blue
                        : Colors.grey,
                    textStyle: TextStyle(
                      color: message.sender.userId == _currentUserId
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _chatController,
                    maxLines: 4,
                    minLines: 1,
                    decoration: InputDecoration(
                      hintText: 'Type a message...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: _sendMessage,
                  icon: const Icon(Icons.send_rounded),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
