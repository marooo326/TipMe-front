import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:tipme_front/models/tip_model.dart';

class PostModel with ChangeNotifier {
  int? id;
  String place, category;
  List<TipModel> tips;

  PostModel({
    this.id,
    required this.place,
    required this.category,
    required this.tips,
  });
  @override
  String toString() {
    return ("[PostModel instance] place:$place, category:$category, tips:$tips");
  }

  void initTipList() {
    tips = [
      TipModel(writerId: 123, comment: ""),
    ];
  }

  void addTip(TipModel tip) {
    tips.add(tip);
    notifyListeners();
  }

  void removeTip(int index) {
    tips.removeAt(index);
    notifyListeners();
  }
}
