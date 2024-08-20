import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:sntr_mobile_banking_user_app/model/second_person_data.dart';

class ReceiverAccountInfoController extends GetxController {
  SecondPersonData get receiverAccountInfo => _receiverAccountInfo;
  bool get inProgress => _inProgress;
  String get errorMessage => _errorMessage ?? "";
  late SecondPersonData _receiverAccountInfo;
  bool _inProgress = false;
  String? _errorMessage;
  Future<bool> getReceiverAccountInfo(String userId) async {
    late bool isSuccess;
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final Reference firebaseStorage = FirebaseStorage.instance.ref().child("user_info").child(userId).child("profilePicture");
    _inProgress = true;
    update();
    try {
      DocumentSnapshot userInfoSnapshot = await firestore.collection("user_info").doc(userId).get();
      String profileImageUrl = await firebaseStorage.getDownloadURL();
      if(userInfoSnapshot.data() != null) {
        isSuccess = true;
        _receiverAccountInfo = SecondPersonData.fromJson(userInfoSnapshot.data() as Map<String, dynamic>, profileImageUrl);
      } else {
        isSuccess = false;
      }
    } catch(error) {
      isSuccess = false;
      _errorMessage = error.toString();
    }
    _inProgress = false;
    update();
    return isSuccess;
  }
}