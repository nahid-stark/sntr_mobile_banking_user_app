import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sntr_mobile_banking_user_app/controller/receiver_account_info_controller.dart';
import 'package:sntr_mobile_banking_user_app/view/screens/money_amount_and_password_for_send_money_screen.dart';

class ReceiverAccountInformationScreen extends StatefulWidget {
  const ReceiverAccountInformationScreen({super.key, required this.userAccountId});

  final String userAccountId;

  @override
  State<ReceiverAccountInformationScreen> createState() => _ReceiverAccountInformationScreenState();
}

class _ReceiverAccountInformationScreenState extends State<ReceiverAccountInformationScreen> {
  @override
  void initState() {
    super.initState();
    Get.find<ReceiverAccountInfoController>().getReceiverAccountInfo(widget.userAccountId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Receiver's Account Info."),
      ),
      body: GetBuilder<ReceiverAccountInfoController>(builder: (receiverAccountInfoController) {
        if (receiverAccountInfoController.inProgress) {
          return const Center(child: CircularProgressIndicator());
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 12),
              child: Container(
                height: 180,
                width: 280,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: Colors.orange,
                    width: 2,
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: CachedNetworkImage(
                    imageUrl: receiverAccountInfoController.receiverAccountInfo.profilePictureUrl ?? "",
                    placeholder: (context, url) => const CircularProgressIndicator(),
                    errorWidget: (context, url, error) => const Icon(Icons.error),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12, top: 48),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Name: ${receiverAccountInfoController.receiverAccountInfo.firstName} ${receiverAccountInfoController.receiverAccountInfo.lastName}",
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    "User ID: ${receiverAccountInfoController.receiverAccountInfo.accountUserId}",
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    "Email: ${receiverAccountInfoController.receiverAccountInfo.email}",
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    "Phone No: ${receiverAccountInfoController.receiverAccountInfo.phoneNo}",
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    "Address: ${receiverAccountInfoController.receiverAccountInfo.address}",
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 32),
                  Padding(
                    padding: const EdgeInsets.only(left: 24, right: 36, bottom: 24, top: 24),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        fixedSize: const Size.fromWidth(double.maxFinite),
                        padding: const EdgeInsets.symmetric(vertical: 0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                        textStyle: const TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 24,
                        ),
                      ),
                      onPressed: () {
                        Get.off(() => MoneyAmountAndPasswordForSendMoneyScreen(receiverUserId: widget.userAccountId));
                      },
                      child: const Text("Yes, He is The Receiver"),
                    ),
                  ),
                ],
              ),
            )
          ],
        );
      }),
    );
  }
}
