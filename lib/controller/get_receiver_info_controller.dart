import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:sntr_mobile_banking_user_app/model/second_person_data.dart';

class GetReceiverInfoController extends GetxController {
  bool get inProgress => _inProgress;

  SecondPersonData get receiverInfo => _receiverInfo;

  String get errorMessage => _errorMessage;
  late bool _isSuccess;
  bool _inProgress = false;
  late SecondPersonData _receiverInfo;
  late String _errorMessage;

  Future<bool> getReceiverInfo(String userId) async {
    _inProgress = true;
    update();
    try {
      final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
      final Reference profilePicture = FirebaseStorage.instance.ref().child("user_info").child(userId).child("profilePicture");
      final DocumentSnapshot documentSnapshot = await firebaseFirestore.collection("user_info").doc(userId).get();
      final String profilePictureUrl = await profilePicture.getDownloadURL();
      if (documentSnapshot.data() != null && profilePictureUrl.isNotEmpty) {
        _isSuccess = true;
        _receiverInfo = SecondPersonData.fromJson(documentSnapshot.data() as Map<String, dynamic>, profilePictureUrl);
      } else {
        _isSuccess = false;
      }
    } catch (error) {
      _isSuccess = false;
      _errorMessage = error.toString();
    }
    _inProgress = false;
    update();
    return _isSuccess;
  }
}
