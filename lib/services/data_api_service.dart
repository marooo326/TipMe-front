import 'dart:async';

import 'package:tipme_front/models/chat_room_model.dart';
import 'package:tipme_front/models/tip_model.dart';

class DataApiService {
  static const String baseUrl = "http://192.168.56.81:8080/apitests/post-test";
  static String userName = "Hyobin";
  static List<ChatRoomModel> chatRoomData = [
    ChatRoomModel(partner: "대휘"),
    ChatRoomModel(partner: "하람"),
    ChatRoomModel(partner: "주은"),
    ChatRoomModel(partner: "성훈"),
  ];

  static Future<List<ChatRoomModel>> getChatRooms() async {
    //임시 채팅방 api
    await Future.delayed(const Duration(seconds: 1), () {});
    return chatRoomData;
  }

  static Future<List<TipModel>> getTips() async {
    late List<TipModel> list;
    list = [
      TipModel(id: 0, writerId: 123, comment: "comment"),
      TipModel(id: 1, writerId: 123, comment: "comment"),
      TipModel(id: 2, writerId: 123, comment: "comment"),
      TipModel(id: 3, writerId: 123, comment: "comment"),
    ];
    await Future.delayed(const Duration(seconds: 1), () {});
    return list;
  }
}
