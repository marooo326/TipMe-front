import 'package:tipme_front/models/user_model.dart';

class TipModel {
  final int? id;
  final UserModel writer;
  String comment;

  TipModel({
    this.id,
    required this.writer,
    required this.comment,
  });

  TipModel.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        comment = json["comment"],
        writer = UserModel.fromJson(json["writer"]);

  Map<String, dynamic> toJson(int? postId) => {
        "postId": postId,
        "comment": comment,
      };

  bool isEmpty() {
    return comment == "";
  }
}
