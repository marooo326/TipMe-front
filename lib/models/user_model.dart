import 'dart:async';

class UserModel {
  String userName;
  String? userEmail;
  String? token;
  final loginStreamController = StreamController<bool>()..add(false);

  UserModel({
    this.userName = "",
    this.userEmail,
    this.token,
  });

  UserModel.fromJson(Map<String, dynamic> json)
      : userName = json["nickname"],
        userEmail = json["email"],
        token = json["jwt"];

  void updateUserInfo(UserModel user) {
    userName = user.userName;
    userEmail = user.userEmail;
    token = user.token;
    loginStreamController.add(true);
  }
}
