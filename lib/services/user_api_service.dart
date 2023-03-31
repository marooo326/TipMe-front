import 'dart:convert';

import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:tipme_front/models/user_info_model.dart';
import 'package:http/http.dart' as http;

class UserApiService {
  static Future<UserInfoModel> loginWithKaKao() async {
    bool isLoggedIn = false;

    if (await AuthApi.instance.hasToken()) {
      try {
        AccessTokenInfo tokenInfo = await UserApi.instance.accessTokenInfo();
        print('토큰 유효성 체크 성공 ${tokenInfo.id} ${tokenInfo.expiresIn}');
        isLoggedIn = true;
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
          isLoggedIn = true;
        } catch (error) {
          print('로그인 실패 $error');
        }
      }
    } else {
      print('발급된 토큰 없음');
      try {
        OAuthToken token = await UserApi.instance.loginWithKakaoAccount();
        print('로그인 성공 ${token.accessToken}');
        isLoggedIn = true;
      } catch (error) {
        print('로그인 실패 $error');
      }
    }

    if (isLoggedIn) {
      User userInfo = await UserApi.instance.me();
      UserInfoModel userInstance = UserInfoModel(
        isValid: true,
        userName: userInfo.kakaoAccount!.profile!.nickname!,
        userEmail: userInfo.kakaoAccount?.email,
      );
      //postUserInfo(userInstance);
      return userInstance;
    } else {
      UserInfoModel userInstance = UserInfoModel(isValid: false);
      return userInstance;
    }
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
      body: jsonEncode(<String, String?>{
        "userName": user.userName,
        "userEmial": user.userEmail,
      }),
    );
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
  }

  static logout() {
    UserApi.instance.logout();
  }
}
