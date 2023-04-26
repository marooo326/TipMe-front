import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:tipme_front/models/message_model.dart';
import 'package:tipme_front/models/post_model.dart';
import 'package:tipme_front/models/tip_model.dart';
import 'package:tipme_front/models/user_model.dart';

class DataApiService {
  static const baseUrl = "http://3.37.181.141:8080/test";

  /// 서버로부터 게시글 목록 조회
  static Future<List<PostModel>> getPosts(String token) async {
    // 게시글 목록을 받아올 post 변수
    List<PostModel> posts;

    // get 요청
    posts = await http.get(
      Uri.parse("$baseUrl/posts"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': token,
      },
      // 받아서 포스트 모델로 변환
    ).then((response) async {
      final json = await jsonDecode(utf8.decode(response.bodyBytes));
      return (json as List<dynamic>).map((post) {
        return PostModel.fromJson(post);
      }).toList();
    });

    return posts;
  }

  /// 새로운 Post(게시글) 등록
  static Future<int> postNewPost(String token, PostModel post) async {
    // post 요청
    final response = await http.post(
      Uri.parse("$baseUrl/post"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': token,
      },
      body: jsonEncode(<String, dynamic>{
        'storeName': post.place,
        'storeType': post.category.toString().split('.').last,
        'tips': post.tips.map((tip) => tip.comment).toList(),
      }),
    );

    return response.statusCode;
  }

  /// 새로운 Tip 등록
  static Future<int> postTip(String token, int postId, TipModel tip) async {
    final response = await http.post(
      Uri.parse("$baseUrl/tip"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': token,
      },
      body: jsonEncode(tip.toJson(postId)),
    );
    return response.statusCode;
  }

  /// 본인이 등록한 Tip 삭제
  static Future<int> removeTip(String token, int tipId) async {
    final response = await http.delete(
      Uri.parse("$baseUrl/tip/$tipId"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': token,
      },
    );
    print(response.body);
    return response.statusCode;
  }

  /// 닉네임 변경
  static Future<int> requestChangeName(String token, String newName) async {
    final response = await http.post(
      Uri.parse("$baseUrl/nickname"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': token,
      },
      body: jsonEncode(
        <String, String>{
          "nickname": newName,
        },
      ),
    );
    return response.statusCode;
  }

  /// 친구 목록 조회
  static Future<List<UserModel>> getFriends(String token) async {
    // get 요청
    final friends = await http.get(
      Uri.parse("$baseUrl/friends"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': token,
      },
      // UserInfoModel로 변환 후 리턴
    ).then((response) async {
      final json = await jsonDecode(utf8.decode(response.bodyBytes));
      return (json as List<dynamic>).map((friend) {
        return UserModel.fromJson(friend);
      }).toList();
    });

    return friends;
  }

  /// 친구 요청 전송
  static Future<int> requestFriend(String token, String receiver) async {
    // post 요청
    final response = await http.post(
      Uri.parse("$baseUrl/friend"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': token,
      },
      body: jsonEncode(
        <String, String>{
          "receiver": receiver,
        },
      ),
    );

    return response.statusCode;
  }

  ///유저에게 온 메세지 조회(친구요청)
  static Future<List<MessageModel>> getMessages(String token) async {
    // get 요청
    final messages = await http.get(
      Uri.parse("$baseUrl/messages"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': token,
      },
      // MessageModel로 변환 후 반환
    ).then((response) async {
      final json = await jsonDecode(utf8.decode(response.bodyBytes));
      return (json as List<dynamic>)
          .map((message) =>
              MessageModel(id: message["id"], sender: message["sender"]))
          .toList();
    });

    return messages;
  }
}
