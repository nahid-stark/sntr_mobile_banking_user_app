import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sntr_mobile_banking_user_app/controller/store_user_account_info_on_server_controller.dart';
import 'package:sntr_mobile_banking_user_app/view/screens/account_creation_complete_screen.dart';
import 'package:sntr_mobile_banking_user_app/view/widgets/loading_symbol.dart';

class InfoSaveOnServerScreen extends StatefulWidget {
  const InfoSaveOnServerScreen({super.key});

  @override
  State<InfoSaveOnServerScreen> createState() => _InfoSaveOnServerScreenState();
}

class _InfoSaveOnServerScreenState extends State<InfoSaveOnServerScreen> {
  StoreUserAccountInfoOnPendingController storeAccountInfoPendingController = Get.find<StoreUserAccountInfoOnPendingController>();

  @override
  void initState() {
    super.initState();
    _gotoAccountCreationCompleteScreen();
  }

  Future<void> _gotoAccountCreationCompleteScreen() async {
    String accountUserId = await storeAccountInfoPendingController.sendUserDataToPendingServer();
    await Future.delayed(const Duration(seconds: 4));
    Get.to(() => AccountCreationCompleteScreen(userAccountNo: accountUserId));
  }

  @override
  Widget build(BuildContext context) {
    return const LoadingSymbol();
  }
}
