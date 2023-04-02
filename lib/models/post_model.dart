import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:tipme_front/models/tip_model.dart';
import 'package:tipme_front/models/user_info_model.dart';

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

  void printInfo() {
    print("[PostModel instance] place:$place, category:$category");
    print("tips:");
    for (var tip in tips) {
      print("\t${tip.comment}");
    }
  }

  void initTips(UserInfoModel writer) {
    tips = [
      TipModel(writer: writer, comment: ""),
    ];
    notifyListeners();
  }

  /// 빈 comment 제거 및 empty 여부 반환
  bool isEmpty() {
    tips.removeWhere((tip) => tip.isEmpty()); // 데이터 제거
    if (tips.isEmpty) {
      return true;
    } else {
      return false;
    }
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
