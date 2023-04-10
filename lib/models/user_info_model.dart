class UserInfoModel {
  final String? userName;
  final String? userEmail;
  final String? token;

  UserInfoModel({
    this.userName,
    this.userEmail = "",
    this.token,
  });

  UserInfoModel.fromJson(Map<String, dynamic> json)
      : userName = json["nickname"],
        userEmail = json["email"],
        token = json["jwt"];
}
