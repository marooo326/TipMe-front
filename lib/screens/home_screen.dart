import 'package:flutter/cupertino.dart';
import 'package:tipme_front/widgets/home_widget.dart';

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
        return HomeWidget(apiData: apiData);
      },
    );
  }
}
