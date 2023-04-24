class UserModel {
  String userName;
  final String? userEmail;
  final String? token;

  UserModel({
    required this.userName,
    required this.userEmail,
    this.token,
  });

  UserModel.fromJson(Map<String, dynamic> json)
      : userName = json["nickname"],
        userEmail = json["email"],
        token = json["jwt"] ?? "";
}
