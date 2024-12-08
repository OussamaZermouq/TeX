
import 'package:tex/app/data/model/User.dart';

class Message{
  String messageId;
  String content;
  User sender;
  String? senderId;
  DateTime createdAt;

  Message({
    required this.messageId,
    required this.content,
    required this.createdAt,
    this.senderId,
    required this.sender,
  });

  factory Message.fromJson(Map<String, dynamic>json){
    return Message(
        messageId: json['messageId'],
        content: json['content'],
        sender : User.fromJson(json['sender']),
        senderId: json['senderId'],
        createdAt: DateTime.parse(json['createdAt']),
    );
  }
  Map<String, dynamic> toJson(){
    return {
      'messageId' : messageId,
      'content':content,
      'senderId':senderId,
      'createdAt' : createdAt.toIso8601String(),
    };
  }

}