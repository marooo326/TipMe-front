import 'dart:async';

import 'package:tipme_front/models/chat_room_model.dart';

class ApiService {
  static const String baseUrl = "none";

  static List<ChatRoomModel> chatRoomData = [
    ChatRoomModel(partner: "대휘"),
    ChatRoomModel(partner: "하람"),
    ChatRoomModel(partner: "주은"),
    ChatRoomModel(partner: "성훈"),
  ];

  static Future<List<ChatRoomModel>> getChatRooms() async {
    //임시 채팅방 api
    await Future.delayed(const Duration(seconds: 2), () {});
    return chatRoomData;
  }
}
