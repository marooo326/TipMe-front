import 'package:flutter/cupertino.dart';
import 'package:tipme_front/screens/login_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final apiData = {
      'nickname': 'Hyobin',
    };
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.square_list_fill),
            label: 'Tips',
          ),
        ],
      ),
      tabBuilder: (BuildContext context, int index) {
        return CupertinoTabView(
          builder: (BuildContext context) {
            return Container(
              child: index == 0
                  ? Column(
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
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        CupertinoListSection(
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
                                CupertinoPageRoute(
                                  builder: (BuildContext context) {
                                    return const LoginScreen();
                                  },
                                ),
                              ),
                            ),
                            const CupertinoListTile.notched(
                              title: Text('받은 메세지'),
                              leading: SizedBox(
                                width: double.infinity,
                                height: double.infinity,
                                child:
                                    Icon(CupertinoIcons.chat_bubble_text_fill),
                              ),
                              trailing: CupertinoListTileChevron(),
                            ),
                            const CupertinoListTile.notched(
                              title: Text('친구 추가'),
                              leading: SizedBox(
                                width: double.infinity,
                                height: double.infinity,
                                child: Icon(CupertinoIcons
                                    .person_crop_circle_badge_plus),
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
                    )
                  : const Text(
                      '0',
                      style: TextStyle(fontSize: 20),
                    ),
            );
          },
        );
      },
    );
  }
}
