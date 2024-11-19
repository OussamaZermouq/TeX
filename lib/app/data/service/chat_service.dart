import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:tex/app/data/provider/chat_api.dart';

import '../model/Chat.dart';


class ChatService{
  final _api = ChatApi();

  Future<int> createChat(String profileIdToAddChat) async{
    http.Response response = await _api.createChat(profileIdToAddChat);
    return response.statusCode;

  }

  Future<List<Chat>?> getChats() async{
    http.Response response = await _api.getChats();

    if (response.statusCode == 200){
      return chatsFromJson(response.body);
    }
    return null;
  }
}