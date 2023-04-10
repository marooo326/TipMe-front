import 'package:tipme_front/models/user_info_model.dart';

class TipModel {
  final int? id;
  final UserInfoModel writer;
  String comment;

  TipModel({
    this.id,
    required this.writer,
    required this.comment,
  });

  TipModel.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        comment = json["comment"],
        writer = UserInfoModel.fromJson(json["writer"]);

  bool isEmpty() {
    return comment == "";
  }
}
