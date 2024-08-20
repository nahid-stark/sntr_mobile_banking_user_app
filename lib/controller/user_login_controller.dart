import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:sntr_mobile_banking_user_app/model/user_login_data_model.dart';
import 'package:sntr_mobile_banking_user_app/view/widgets/snackbar_message.dart';

class UserLoginController extends GetxController{
  bool _inProgress = false;
  bool get inProgress => _inProgress;
  late UserLoginDataModel userLoginDataModel;

  Future<bool> userLoginController(String userAccountId) async {
    bool isSuccess = false;
    _inProgress = true;
    final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    update();
    try {
      DocumentSnapshot<Map<String, dynamic>> userData = await firebaseFirestore.collection("user_info").doc(userAccountId).get();
      if(userData.data() == null) {
        _inProgress = false;
        update();
        return isSuccess;
      } else {
        isSuccess = true;
        userLoginDataModel = UserLoginDataModel.fromJson(userData.data() as Map<String, dynamic>);
      }
    } catch(error) {
      SnackBarMessage.snackbarMessage(title: "SomeThing Went Wrong", message: "Error", type: false);
    }
    _inProgress = false;
    update();
    return isSuccess;
  }
}