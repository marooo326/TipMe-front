import 'package:flutter/foundation.dart';

class PostModel with ChangeNotifier {
  String place, category;
  List<String> tips;
  PostModel({
    required this.place,
    required this.category,
    required this.tips,
  });
  @override
  String toString() {
    return ("[PostModel instance] place:$place, category:$category, tips:$tips");
  }

  void addTip(int index) {
    tips.add("");
    notifyListeners();
  }

  void removeTip(int index) {
    tips.removeAt(index);
    notifyListeners();
  }
}
