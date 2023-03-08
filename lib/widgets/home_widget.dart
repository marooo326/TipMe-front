import 'package:flutter/cupertino.dart';
import 'package:tipme_front/screens/message_screen.dart';
import 'package:tipme_front/widgets/change_nickname_widget.dart';

class HomeWidget extends StatelessWidget {
  const HomeWidget({
    super.key,
    required this.apiData,
  });

  final Map<String, String> apiData;

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
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text(
                    "Welcome, ${apiData['nickname']}",
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                CupertinoListSection.insetGrouped(
                  header: const Text(
                    'Menu',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  children: [
                    CupertinoListTile.notched(
                      title: const Text('닉네임 변경'),
                      leading: const SizedBox(
                        width: double.infinity,
                        height: double.infinity,
                        child: Icon(CupertinoIcons.arrow_2_circlepath),
                      ),
                      trailing: const CupertinoListTileChevron(),
                      onTap: () => Navigator.of(context).push(
                        CupertinoModalPopupRoute(
                          builder: (BuildContext context) {
                            return const ChangeNicknameWidget();
                          },
                        ),
                      ),
                    ),
                    CupertinoListTile.notched(
                      title: const Text('받은 메세지'),
                      leading: const SizedBox(
                        width: double.infinity,
                        height: double.infinity,
                        child: Icon(CupertinoIcons.chat_bubble_text_fill),
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
                    const CupertinoListTile.notched(
                      title: Text('친구 추가'),
                      leading: SizedBox(
                        width: double.infinity,
                        height: double.infinity,
                        child:
                            Icon(CupertinoIcons.person_crop_circle_badge_plus),
                      ),
                      trailing: CupertinoListTileChevron(),
                    ),
                    const CupertinoListTile.notched(
                      title: Text('로그아웃'),
                      leading: SizedBox(
                        width: double.infinity,
                        height: double.infinity,
                        child: Icon(CupertinoIcons.xmark_circle),
                      ),
                      trailing: CupertinoListTileChevron(),
                    ),
                  ],
                )
              ],
            ));
      },
    );
  }
}
