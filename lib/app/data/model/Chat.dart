import 'dart:convert';
import 'Message.dart';
import 'Profile.dart';

List<Chat> chatsFromJson(String chatList) =>
    List<Chat>.from(jsonDecode(chatList).map((chat) => Chat.fromJson(chat)));

class Chat {
  String chatId;
  List<Profile> members;
  List<Message>? messages;

  Chat({
    required this.chatId,
    required this.members,
    this.messages,
  });

  factory Chat.fromJson(Map<String, dynamic> json) {
    List<Profile> members = List<Profile>.from(json['members'].map((member) => Profile.fromJson(member)));
    List<Message>? messages = json['messages'][0] != null
        ? List<Message>.from(json['messages'].map((message) => Message.fromJson(message)))
        : [];

    return Chat(
      chatId: json['chatId'],
      members: members,
      messages: messages,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'chatUUID': chatId,
      'members': members.map((member) => member.toJson()).toList(),
      'messages': messages?.map((message) => message.toJson()).toList(),
    };
  }
}