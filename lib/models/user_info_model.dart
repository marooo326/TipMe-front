class UserInfoModel {
  final bool isValid;
  final String? userName;
  final String? userEmail;
  UserInfoModel({
    required this.isValid,
    this.userName,
    this.userEmail = "",
  });
}
