class TipModel {
  final int? id;
  final int writerId;
  String comment;
  TipModel({
    this.id,
    required this.writerId,
    required this.comment,
  });

  bool isEmpty() {
    return comment == "";
  }
}
