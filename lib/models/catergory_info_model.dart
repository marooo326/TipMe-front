import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum Categories {
  cafe("카페", CupertinoColors.systemOrange, Icons.coffee),
  restaurant("식당", CupertinoColors.systemPurple, Icons.restaurant_menu),
  bar("술집", CupertinoColors.systemGreen, Icons.wine_bar_sharp),
  etc("기타", CupertinoColors.systemIndigo, Icons.place_outlined);

  final String name;
  final Color color;
  final IconData icon;
  const Categories(this.name, this.color, this.icon);

  static List<String> toList() {
    List<String> names = [];
    for (var value in Categories.values) {
      names.add(value.name);
    }
    return names;
  }

  static IconData getIcon(String category) {
    if (category == Categories.cafe.name) {
      return Categories.cafe.icon;
    } else if (category == Categories.restaurant.name) {
      return Categories.restaurant.icon;
    } else if (category == Categories.bar.name) {
      return Categories.bar.icon;
    } else {
      return Categories.etc.icon;
    }
  }

  static Color getColor(String category) {
    if (category == Categories.cafe.name) {
      return Categories.cafe.color;
    } else if (category == Categories.restaurant.name) {
      return Categories.restaurant.color;
    } else if (category == Categories.bar.name) {
      return Categories.bar.color;
    } else {
      return Categories.etc.color;
    }
  }
}

class CategoryInfoModel with ChangeNotifier {
  List<bool> isSelected = List.filled(Categories.values.length + 1, true);

  CategoryInfoModel();

  void onClicked(int index) {
    if (index == 0) {
      if (isSelected[0] == false) {
        for (var index = 0; index < isSelected.length; ++index) {
          isSelected[index] = true;
        }
      } else {
        for (var index = 0; index < isSelected.length; ++index) {
          isSelected[index] = false;
        }
      }
    } else {
      bool isAllSelected = true;
      isSelected[index] = !isSelected[index];
      for (var index = 1; index < isSelected.length; ++index) {
        isAllSelected = isSelected[index] && isAllSelected;
      }
      isAllSelected ? isSelected[0] = true : isSelected[0] = false;
    }
    notifyListeners();
  }
}
