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

  bool isEmpty() {
    return comment == "";
  }
}
