import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:tipme_front/screens/auth_screen.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  final kakaoAppKey = dotenv.env['KAKAO_APP_KEY'];
  final kakaoJsAppKey = dotenv.env['KAKAO_JS_APP_KEY'];

  // 웹 환경에서 카카오 로그인을 정상적으로 완료하려면 runApp() 호출 전 아래 메서드 호출 필요
  WidgetsFlutterBinding.ensureInitialized();
  // runApp() 호출 전 Flutter SDK 초기화
  KakaoSdk.init(
    nativeAppKey: kakaoAppKey,
    javaScriptAppKey: kakaoJsAppKey,
  );
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      theme: CupertinoThemeData(brightness: Brightness.light),
      home: AuthScreen(),
    );
  }
}
