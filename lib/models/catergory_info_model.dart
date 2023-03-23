import 'package:flutter/cupertino.dart';

enum Categories {
  all("전체보기", CupertinoColors.systemBlue),
  cafe("카페", CupertinoColors.systemOrange),
  restaurant("식당", CupertinoColors.systemPurple),
  bar("술집", CupertinoColors.systemGreen),
  etc("기타", CupertinoColors.systemIndigo);

  final String name;
  final Color color;
  const Categories(this.name, this.color);

  static List<String> toList() {
    List<String> names = [];
    for (var value in Categories.values) {
      value.index != 0 ? names.add(value.name) : null;
    }
    return names;
  }
}

class CategoryInfoModel with ChangeNotifier {
  List<bool> isSelected = List.filled(Categories.values.length, true);
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
