


class Message{
  String messageId;
  String content;
  DateTime createdAt;

  Message({
    required this.messageId,
  required this.content,
  required this.createdAt
  });
  factory Message.fromJson(Map<String, dynamic>json){
    return Message(
        messageId: json['messageId'],
        content: json['content'],
        createdAt: json['createdAt']
    );

  }
  Map<String, dynamic> toJson(){
    return {
      'messageId' : messageId,
      'content':content,
      'createdAt' : createdAt,
    };
  }

}