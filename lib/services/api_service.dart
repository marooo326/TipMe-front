import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:tipme_front/models/chat_room_model.dart';
import 'package:tipme_front/models/user_info_model.dart';

class ApiService {
  static const String baseUrl = "http://192.168.56.81:8080/apitests/post-test";
  static String userName = "Hyobin";
  static List<ChatRoomModel> chatRoomData = [
    ChatRoomModel(partner: "대휘"),
    ChatRoomModel(partner: "하람"),
    ChatRoomModel(partner: "주은"),
    ChatRoomModel(partner: "성훈"),
  ];

  static Future<UserInfoModel> loginWithKaKao() async {
    if (await AuthApi.instance.hasToken()) {
      try {
        AccessTokenInfo tokenInfo = await UserApi.instance.accessTokenInfo();
        print('토큰 유효성 체크 성공 ${tokenInfo.id} ${tokenInfo.expiresIn}');
        User user = await UserApi.instance.me();
        UserInfoModel userInstance = UserInfoModel(
          userName: user.kakaoAccount!.profile!.nickname!,
          userEmail: user.kakaoAccount?.email,
        );
        print(userInstance.userName);
        return userInstance;
      } catch (error) {
        if (error is KakaoException && error.isInvalidTokenError()) {
          print('토큰 만료 $error');
        } else {
          print('토큰 정보 조회 실패 $error');
        }

        try {
          // 카카오 계정으로 로그인
          OAuthToken token = await UserApi.instance.loginWithKakaoAccount();
          print('로그인 성공 ${token.accessToken}');
        } catch (error) {
          print('로그인 실패 $error');
        }
      }
    } else {
      print('발급된 토큰 없음');
      try {
        OAuthToken token = await UserApi.instance.loginWithKakaoAccount();
        print('로그인 성공 ${token.accessToken}');
      } catch (error) {
        print('로그인 실패 $error');
      }
    }
    return UserInfoModel(userName: "123");
  }

  ///미구현
  static Future<dynamic> loginWithNaver() async {}

  ///미구현
  static Future<dynamic> loginWithGoogle() async {}

  ///미구현
  static void postUserInfo(UserInfoModel user) async {
    final url = Uri.parse('http://192.168.56.81:8080/apitests/post');
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'title': "title",
      }),
    );
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
  }

  static Future<UserInfoModel> getUserInfo() async {
    //토큰으로
    return UserInfoModel(userName: userName, userEmail: "");
  }

  static Future<List<ChatRoomModel>> getChatRooms() async {
    //임시 채팅방 api
    await Future.delayed(const Duration(seconds: 1), () {});
    return chatRoomData;
  }
}
