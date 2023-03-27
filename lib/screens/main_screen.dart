import 'package:flutter/cupertino.dart';
import 'package:tipme_front/screens/home_screen.dart';
import 'package:tipme_front/screens/tips_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({
    super.key,
  });

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    super.initState();
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
        if (index == 0) {
          return const HomeScreen();
        } else if (index == 1) {
          return const TipsScreen();
        }
        return const CupertinoActivityIndicator();
      },
    );
  }
}
