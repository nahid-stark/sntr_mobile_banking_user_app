class UserLoginDataModel {
  String? password;
  bool? accountOkay;

  UserLoginDataModel(
    this.password,
    this.accountOkay,
  );

  UserLoginDataModel.fromJson(Map<String, dynamic> json) {
    password = json["password"];
    accountOkay = json["accountOkay"];
  }
}
