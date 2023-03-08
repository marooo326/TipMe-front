class ChatRoomModel {
  final String partner,
      latest = "친구 요청이 도착했습니다."; //메세지 기능 미구현으로 친구추가 수락 용도로만 사용
  final bool isFriendRequest = true;

  ChatRoomModel({
    required this.partner,
    //required this.latest,
    //required this.isFriendRequest,
  });
}
