import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:tipme_front/models/user_model.dart';
import 'package:tipme_front/services/user_api_service.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<UserModel>(
      builder: (context, user, child) {
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
                          await UserApiService.loginWithKaKao().then(
                            (userInfo) {
                              if (userInfo != null) {
                                user.updateUserInfo(userInfo);
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
      },
    );
  }
}
