import 'package:flutter/cupertino.dart';
import 'package:tipme_front/models/user_info_model.dart';
import 'package:tipme_front/screens/home_screen.dart';
import 'package:tipme_front/screens/tips_screen.dart';
import 'package:tipme_front/services/api_service.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late final Future<UserInfoModel> userInfo;

  @override
  void initState() {
    super.initState();
    userInfo = ApiService.getUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    int currentIndex = 1;
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.square_list_fill),
            label: 'Tips',
          ),
        ],
        currentIndex: currentIndex,
        onTap: (int index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
      tabBuilder: (BuildContext context, int index) {
        return FutureBuilder(
          future: userInfo,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (index == 0) {
                return HomeScreen(
                  userInfo: snapshot.data!,
                );
              } else if (index == 1) {
                return TipsScreen(
                  userInfo: snapshot.data!,
                );
              }
            }
            return const CupertinoActivityIndicator();
          },
        );
      },
    );
  }
}
