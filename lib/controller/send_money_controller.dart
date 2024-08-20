import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class SendMoneyController extends GetxController {
  bool _inProgress = false;
  late bool _isSuccess;
  late String errorMessage;
  Future<bool> sendMoney(String receiverUserId) {
    _inProgress = true;
    update();
    final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    try {

    } catch(error) {
      _isSuccess = false;
      errorMessage = error.toString();
    }
    return _isSuccess;
  }
}