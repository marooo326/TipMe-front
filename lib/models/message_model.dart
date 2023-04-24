class MessageModel {
  final int id;
  final String sender, latest = "친구 요청이 도착했습니다.";
  //메세지 기능 미구현으로 친구추가 수락 용도로만 사용

  MessageModel({
    required this.id,
    required this.sender,
  });
}
