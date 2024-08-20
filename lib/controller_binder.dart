import 'package:get/get.dart';
import 'package:sntr_mobile_banking_user_app/controller/home_screen_controller.dart';
import 'package:sntr_mobile_banking_user_app/controller/otp_verification_controller.dart';
import 'package:sntr_mobile_banking_user_app/controller/receiver_account_info_controller.dart';
import 'package:sntr_mobile_banking_user_app/controller/send_money_controller.dart';
import 'package:sntr_mobile_banking_user_app/controller/store_user_account_info_on_server_controller.dart';
import 'package:sntr_mobile_banking_user_app/controller/transaction_history_controller.dart';
import 'package:sntr_mobile_banking_user_app/controller/user_existence_check_controller.dart';
import 'package:sntr_mobile_banking_user_app/controller/user_login_controller.dart';

class ControllerBinder extends Bindings {
  @override
  void dependencies() {
    Get.put(StoreUserAccountInfoOnPendingController());
    Get.put(OtpVerificationController());
    Get.put(UserLoginController());
    Get.put(HomeScreenController());
    Get.put(TransactionHistoryController());
    Get.put(ReceiverAccountInfoController());
    Get.put(UserExistenceCheckController());
    Get.put(ReceiverAccountInfoController());
    Get.put(SendMoneyController());
  }
}