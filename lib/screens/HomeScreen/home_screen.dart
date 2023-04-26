import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:tipme_front/models/user_model.dart';
import 'package:tipme_front/screens/HomeScreen/friend_list_screen.dart';
import 'package:tipme_front/screens/HomeScreen/message_screen.dart';
import 'package:tipme_front/services/data_api_service.dart';
import 'package:tipme_front/services/user_api_service.dart';
import 'package:tipme_front/utils/functions.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final UserModel user;

  /// 이름 변경 함수
  void _showNicknameChangePopup() async {
    final String? newName = await showTextFieldDialog(
      context: context,
      message: "변경할 이름을 입력해주세요!",
      placeholder: "3~8자 이내, 공백 및 특수문자 입력불가",
    );

    if (newName != null) {
      if (isValidName(newName)) {
        final response =
            await DataApiService.requestChangeName(user.token!, newName);

        if (response == 200) {
          // Ok
          setState(() {
            user.userName = newName;
          });
        } else if (response == 400) {
          // Bad requeset
          print("유효하지 않은 문자 존재");
        } else if (response == 409) {
          // Duplicated name
          print("중복된 이름 존재");
        }
      } else {
        showAlertMessage(context, "유효하지 않은 이름입니다.");
      }
    }
  }

  /// 친구 요청 함수
  void _showFriendRequestPopup() async {
    final String? receiver = await showTextFieldDialog(
      context: context,
      message: "새로운 친구의 이름을 입력해주세요!",
      placeholder: "3~8자 이내, 공백 및 특수문자 입력불가",
    );

    if (receiver != null) {
      final response =
          await DataApiService.requestFriend(user.token!, receiver);
      if (response == 200) {
        // Ok
        showAlertMessage(context, "친구 요청이 완료되었습니다.");
        print("$receiver에게 친구요청 완료");
      } else if (response == 400) {
        // Bad requeset
        showAlertMessage(context, "존재하지 않는 사용자입니다.");
        print("존재하지 않는 이름");
      } else if (response == 409) {
        // already friend or request exitst
        showAlertMessage(context, "이미 친구이거나 친구 요청이 존재합니다.");
        print("이미 친구 또는 요청 상태");
      }
    }
  }

  @override
  void initState() {
    user = Provider.of<UserModel>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoTabView(
      builder: (BuildContext context) {
        return Container(
          decoration:
              const BoxDecoration(color: Color.fromARGB(255, 242, 242, 247)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const SizedBox(
                height: 100,
              ),

              // Welcome, ${username}
              Padding(
                padding: const EdgeInsets.all(20),
                child: Text(
                  "Welcome, ${user.userName}",
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              // Menu
              CupertinoListSection.insetGrouped(
                header: const Text(
                  'Menu',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                children: [
                  // 닉네임 변경
                  CupertinoListTile.notched(
                    title: const Text('닉네임 변경'),
                    leading: const SizedBox(
                      width: double.infinity,
                      height: double.infinity,
                      child: Icon(CupertinoIcons.arrow_2_circlepath),
                    ),
                    trailing: const CupertinoListTileChevron(),
                    onTap: _showNicknameChangePopup,
                  ),

                  // 친구 목록 보기
                  CupertinoListTile.notched(
                    title: const Text('친구 목록'),
                    leading: const SizedBox(
                      width: double.infinity,
                      height: double.infinity,
                      child: Icon(CupertinoIcons.list_bullet),
                    ),
                    trailing: const CupertinoListTileChevron(),
                    onTap: () => Navigator.of(context).push(
                      CupertinoPageRoute(
                        builder: (BuildContext context) {
                          return const FriendListScreen();
                        },
                      ),
                    ),
                  ),

                  // 친구 추가
                  CupertinoListTile.notched(
                    title: const Text('친구 추가'),
                    leading: const SizedBox(
                      width: double.infinity,
                      height: double.infinity,
                      child: Icon(CupertinoIcons.person_crop_circle_badge_plus),
                    ),
                    trailing: const CupertinoListTileChevron(),
                    onTap: _showFriendRequestPopup,
                  ),

                  // 받은 요청 목록 보기
                  CupertinoListTile.notched(
                    title: const Text('받은 요청'),
                    leading: const SizedBox(
                      width: double.infinity,
                      height: double.infinity,
                      child: Icon(CupertinoIcons.app_badge),
                    ),
                    trailing: const CupertinoListTileChevron(),
                    onTap: () => Navigator.of(context).push(
                      CupertinoPageRoute(
                        builder: (BuildContext context) {
                          return const MessageScreen();
                        },
                      ),
                    ),
                  ),

                  // 로그아웃
                  CupertinoListTile.notched(
                    title: const Text('로그아웃'),
                    leading: const SizedBox(
                      width: double.infinity,
                      height: double.infinity,
                      child: Icon(CupertinoIcons.xmark_circle),
                    ),
                    trailing: const CupertinoListTileChevron(),
                    onTap: () {
                      UserApiService.logout();
                      // StreamBuilder 적용하기
                      // Navigator.of(context).pushReplacement(
                      //   CupertinoPageRoute(
                      //     builder: (context) => const LoginScreen(),
                      //   ),
                      // );
                    },
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}