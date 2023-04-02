import 'dart:async';

import 'package:tipme_front/models/catergory_info_model.dart';
import 'package:tipme_front/models/chat_room_model.dart';
import 'package:tipme_front/models/post_model.dart';
import 'package:tipme_front/models/tip_model.dart';
import 'package:tipme_front/models/user_info_model.dart';

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

  static Future<List<PostModel>> getPosts(UserInfoModel user) async {
    //user info를 이용해 서버에서 데이터 받아온 후 return
    return List.generate(
      4,
      (index) => PostModel(
        id: index,
        place: "place $index", //임시
        category: Categories.values[index].name,
        tips: List.generate(
          5,
          (index) =>
              TipModel(id: index, writer: user, comment: "comment $index"),
        ),
      ),
    );
  }

  static Future<List<TipModel>> getTips(UserInfoModel user, int postId) async {
    return List.generate(
      5,
      (index) => TipModel(id: index, writer: user, comment: "comment $index"),
    );
  }

  static void postNewPost(UserInfoModel user, PostModel post) {
    //서버에게 새로운 post post 요청
  }

  static void postTip(UserInfoModel user, int postId, TipModel tip) {
    //서버에게 tip post 요청
  }
}
