import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class UserExistenceCheckController extends GetxController {
  bool get inProgress => _inProgress;
  String get errorMessage => _errorMessage;
  late bool _isSuccess;
  late String _errorMessage;
  bool _inProgress = false;
  Future<bool> checkUserExistence(String userId) async {
    _inProgress = true;
    update();
    try{
      final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
      DocumentSnapshot documentSnapshot = await firebaseFirestore.collection("user_info").doc(userId).get();
      if(documentSnapshot.data() == null) {
        _isSuccess = false;
      } else {
        _isSuccess = true;
      }
    } catch(error) {
      _isSuccess = false;
      _errorMessage = error.toString();
    }
    _inProgress = false;
    update();
    return _isSuccess;
  }
}