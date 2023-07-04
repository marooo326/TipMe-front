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
        return Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage('assets/images/background.jpeg'), // 배경 이미지
            ),
          ),
          child: CupertinoPageScaffold(
            backgroundColor: CupertinoColors.white.withOpacity(0.3),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/TipMe_logo.png",
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(
                        height: 140,
                      ),
                      Container(
                        width: 250,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          boxShadow: [
                            BoxShadow(
                                color:
                                    CupertinoColors.systemGrey.withOpacity(0.8),
                                spreadRadius: 5,
                                blurRadius: 10,
                                offset: const Offset(0, 3)),
                          ],
                        ),
                        child: CupertinoButton(
                          padding: const EdgeInsets.all(0),
                          child: Image.asset(
                            "assets/images/kakao_login.png",
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
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Container(
                        width: 250,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          boxShadow: [
                            BoxShadow(
                                color:
                                    CupertinoColors.systemGrey.withOpacity(0.8),
                                spreadRadius: 5,
                                blurRadius: 10,
                                offset: const Offset(0, 3)),
                          ],
                        ),
                        child: CupertinoButton(
                          padding: const EdgeInsets.all(0),
                          child: Image.asset(
                            "assets/images/naver_login.png",
                          ),
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
