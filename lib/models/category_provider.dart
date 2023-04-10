import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/constants.dart';

class CategoryProvider with ChangeNotifier {
  List<bool> isSelected = List.filled(Categories.values.length + 1, true);

  CategoryProvider();

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
