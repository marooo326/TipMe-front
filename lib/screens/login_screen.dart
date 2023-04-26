import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:tipme_front/screens/main_screen.dart';
import 'package:tipme_front/services/user_api_service.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "images/TipMe logo.png",
            ),
            Transform.scale(
              scale: 0.7,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CupertinoButton(
                    padding: const EdgeInsets.all(0),
                    child: Image.asset(
                      "images/kakaoLogin.png",
                    ),
                    onPressed: () async {
                      UserApiService.loginWithKaKao().then(
                        (userInfo) {
                          if (userInfo != null) {
                            Navigator.of(context).pushReplacement(
                              CupertinoPageRoute(
                                builder: (context) => Provider.value(
                                  value: userInfo,
                                  child: const MainScreen(),
                                ),
                              ),
                            );
                          }
                        },
                      );
                    },
                  ),
                  CupertinoButton(
                      padding: const EdgeInsets.all(0),
                      child: Image.asset(
                        "images/naverLogin.png",
                      ),
                      onPressed: () {}),
                  CupertinoButton(
                    padding: const EdgeInsets.all(0),
                    child: Image.asset(
                      "images/googleLogin.png",
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
