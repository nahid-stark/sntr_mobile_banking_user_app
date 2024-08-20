class HomeScreenDataModel {
  String? accountUserId;
  String? userEmail;
  String? profileImageUrl;

  HomeScreenDataModel({
    this.userEmail,
    this.accountUserId,
    this.profileImageUrl
  });

  HomeScreenDataModel.fromJson(Map<String, dynamic> json) {
    accountUserId = json["accountUserId"];
    userEmail = json["email"];
    profileImageUrl = json["profileImageUrl"];
  }
}
