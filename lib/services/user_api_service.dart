import 'dart:convert';

import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:tipme_front/models/user_model.dart';
import 'package:http/http.dart' as http;

class UserApiService {
  static const baseUrl = "http://3.37.181.141:8080/test";

  /// 카카오톡 로그인 함수
  static Future<UserModel?> loginWithKaKao() async {
    bool isKakaoAuthorized = false;

    // 카카오톡 인증
    if (await AuthApi.instance.hasToken()) {
      try {
        AccessTokenInfo tokenInfo = await UserApi.instance.accessTokenInfo();
        print('[Kakao] 토큰 유효성 체크 성공 ${tokenInfo.id} ${tokenInfo.expiresIn}');
        isKakaoAuthorized = true;
      } catch (error) {
        if (error is KakaoException && error.isInvalidTokenError()) {
          print('[Kakao] 토큰 만료 $error');
        } else {
          print('[Kakao] 토큰 정보 조회 실패 $error');
        }

        try {
          /// 카카오 계정으로 로그인 (재로그인)
          OAuthToken token = await UserApi.instance.loginWithKakaoAccount();
          print('[Kakao] 로그인 성공 ${token.accessToken}');
          isKakaoAuthorized = true;
        } catch (error) {
          print('[Kakao] 로그인 실패 $error');
        }
      }
    } else {
      print('[Kakao] 발급된 토큰 없음');
      try {
        /// 카카오계정으로 로그인(신규)
        OAuthToken token = await UserApi.instance.loginWithKakaoAccount();
        print('[Kakao] 로그인 성공 ${token.accessToken}');
        isKakaoAuthorized = true;
      } catch (error) {
        print('[Kakao] 로그인 실패 $error');
      }
    }

    /// 카카오 로그인 성공 시 서버에게 요청
    User userInfo = await UserApi.instance.me();
    if (isKakaoAuthorized && userInfo.kakaoAccount?.email != null) {
      // 서버에 login 요청
      final response = await http.post(
        Uri.parse("$baseUrl/kakaoLogin"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
          <String, String>{
            "nickname": userInfo.kakaoAccount!.profile!.nickname!,
            "email": userInfo.kakaoAccount!.email!,
          },
        ),
      );

      if (response.statusCode == 200) {
        // 응답 코드 200 (로그인 성공)
        print("[Server] Login Success");
        final json = jsonDecode(utf8.decode(response.bodyBytes));
        return UserModel.fromJson(json);
      } else if (response.statusCode == 303) {
        // 응답 코드 303 (중복 닉네임: 닉네임 자동 변경 후 고지)
        print("[Server] Duplicated nickname");
        final json = jsonDecode(utf8.decode(response.bodyBytes));
        return UserModel.fromJson(json);
      } else if (response.statusCode == 400) {
        // 응답 코드 400 (로그인 거절)
        print("[Server] Reject");
      }
    }

    return null;
  }

  ///미구현
  static Future<dynamic> loginWithNaver() async {}

  ///미구현
  static Future<dynamic> loginWithGoogle() async {}
}
