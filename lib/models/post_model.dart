import 'package:flutter/foundation.dart';
import 'package:tipme_front/models/tip_model.dart';
import 'package:tipme_front/models/user_model.dart';
import 'package:tipme_front/utils/constants.dart';

class PostModel with ChangeNotifier {
  int? id;
  String place;
  Categories category;
  List<TipModel> tips;

  PostModel({
    this.id,
    required this.place,
    required this.category,
    required this.tips,
  });

  PostModel.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        place = json["storeName"],
        category = Categories.getCatetory(json["storeType"]),
        tips = (json["tips"] as List<dynamic>).map((tip) {
          return TipModel.fromJson(tip);
        }).toList();

  Map<String, dynamic> toJson() => {
        "storeName": place,
        "storeType": category.toString().split('.').last,
        "tips": tips.map((tip) => tip.toJson(id)).toList().toString(),
      };

  void printInfo() {
    print("[PostModel instance] place:$place, category:$category");
    print("tips:");
    for (var tip in tips) {
      print("\t${tip.comment}");
    }
  }

  void initTips(UserModel writer) {
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
