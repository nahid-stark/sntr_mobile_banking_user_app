import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:sntr_mobile_banking_user_app/data/logged_in_user_data.dart';
import 'package:sntr_mobile_banking_user_app/model/home_screen_data_model.dart';

class HomeScreenController extends GetxController {
  bool get inProgress => _inProgress;
  HomeScreenDataModel get homeScreenDataModel => _homeScreenDataModel;
  late HomeScreenDataModel _homeScreenDataModel;
  bool _inProgress = false;
  late bool _isSuccess;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  Future<bool> getHomeScreenData() async {
    _inProgress = true;
    update();
    DocumentSnapshot<Map<String, dynamic>> documentSnapshot = await _firebaseFirestore
        .collection("user_info")
        .doc(LoggedInUserData.userAccount)
        .get();
    final Reference firebaseStorage = FirebaseStorage
        .instance
        .ref()
        .child("user_info")
        .child(LoggedInUserData.userAccount)
        .child("profilePicture");
    String profilePicture = await firebaseStorage.getDownloadURL();
    if(documentSnapshot.data() != null && profilePicture.isNotEmpty) {
      _isSuccess = true;
      Map<String, dynamic> json = {
        "accountUserId" : LoggedInUserData.userAccount,
        "email" : documentSnapshot.get("email"),
        "profileImageUrl" : profilePicture,
      };
      _homeScreenDataModel = HomeScreenDataModel.fromJson(json);
    } else {
      _isSuccess = false;
    }
    _inProgress = false;
    update();
    return _isSuccess;
  }
}