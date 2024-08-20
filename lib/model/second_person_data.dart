class SecondPersonData {
  String? accountUserId;
  String? firstName;
  String? lastName;
  String? profilePictureUrl;
  String? email;
  String? phoneNo;
  String? address;

  SecondPersonData({
    this.profilePictureUrl,
    this.accountUserId,
    this.firstName,
    this.address,
    this.phoneNo,
    this.email,
    this.lastName,
  });

  SecondPersonData.fromJson(Map<String, dynamic> json, String profilePicture) {
    profilePictureUrl = profilePicture;
    accountUserId = json["accountUserId"];
    firstName = json["firstName"];
    lastName = json["lastName"];
    email = json["email"];
    phoneNo = json["phoneNo"];
    address = json["address"];
  }
}
