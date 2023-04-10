import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum Categories {
  CAFE(1, "카페", CupertinoColors.systemOrange, Icons.coffee),
  RESTAURANT(2, "식당", CupertinoColors.systemPurple, Icons.restaurant_menu),
  BAR(3, "술집", CupertinoColors.systemGreen, Icons.wine_bar_sharp),
  OTHER(4, "기타", CupertinoColors.systemIndigo, Icons.place_outlined);

  final int id;
  final String name;
  final Color color;
  final IconData icon;
  const Categories(this.id, this.name, this.color, this.icon);

  static Categories getCatetory(String category) {
    if (category.toUpperCase() == "CAFE") {
      return Categories.CAFE;
    } else if (category.toUpperCase() == "RESTAURANT") {
      return Categories.RESTAURANT;
    } else if (category.toUpperCase() == "BAR") {
      return Categories.BAR;
    }
    return Categories.OTHER;
  }

  static IconData getIcon(String category) {
    if (category == Categories.CAFE.name) {
      return Categories.CAFE.icon;
    } else if (category == Categories.RESTAURANT.name) {
      return Categories.RESTAURANT.icon;
    } else if (category == Categories.BAR.name) {
      return Categories.BAR.icon;
    } else {
      return Categories.OTHER.icon;
    }
  }

  static Color getColor(String category) {
    if (category == Categories.CAFE.name) {
      return Categories.CAFE.color;
    } else if (category == Categories.RESTAURANT.name) {
      return Categories.RESTAURANT.color;
    } else if (category == Categories.BAR.name) {
      return Categories.BAR.color;
    } else {
      return Categories.OTHER.color;
    }
  }
}
