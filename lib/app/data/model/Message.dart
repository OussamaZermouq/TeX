
class Message{
  String messageId;
  String content;
  String senderId;
  DateTime createdAt;

  Message({
    required this.messageId,
    required this.content,
    required this.createdAt,
    required this.senderId,
  });

  factory Message.fromJson(Map<String, dynamic>json){
    return Message(
        messageId: json['messageId'],
        content: json['content'],
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