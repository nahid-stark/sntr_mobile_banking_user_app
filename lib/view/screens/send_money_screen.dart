import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sntr_mobile_banking_user_app/controller/transaction_history_controller.dart';
import 'package:sntr_mobile_banking_user_app/controller/user_existence_check_controller.dart';
import 'package:sntr_mobile_banking_user_app/view/screens/receiver_account_information_screen.dart';
import 'package:sntr_mobile_banking_user_app/view/widgets/snackbar_message.dart';

class SendMoneyScreen extends StatefulWidget {
  const SendMoneyScreen({super.key});

  @override
  State<SendMoneyScreen> createState() => _SendMoneyScreenState();
}

class _SendMoneyScreenState extends State<SendMoneyScreen> {
  final TextEditingController _userAccountNoTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    Get.find<TransactionHistoryController>().getUserTransactionHistory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Send Money"),
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Give Receiver's Account User Name",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.green,
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  validator: (String? value) {
                    if (value?.isEmpty ?? true) {
                      return "Enter User Account No.";
                    }
                    return null;
                  },
                  controller: _userAccountNoTEController,
                  decoration: const InputDecoration(
                    hintText: "User Account No.",
                    labelText: "User Account No.",
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  "Recent Transactions (Suggestions)",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  height: 320,
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.orange,
                      width: 2,
                    ),
                  ),
                  child: GetBuilder<TransactionHistoryController>(
                    builder: (TransactionHistoryController transactionHistoryController) {
                      if (transactionHistoryController.inProgress) {
                        return const SizedBox(
                          height: 20,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Please Wait....",
                                  style: TextStyle(
                                    fontSize: 24,
                                    color: Colors.black54,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                CircularProgressIndicator(),
                              ],
                            ),
                          ),
                        );
                      }
                      return ListView.builder(
                        itemCount: transactionHistoryController.combinedUniqueUserDataList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: ListTile(
                              leading: CircleAvatar(
                                radius: 35,
                                child: ClipOval(
                                  child: CachedNetworkImage(
                                    fit: BoxFit.cover,
                                    imageUrl: transactionHistoryController.combinedUniqueUserDataList[index].profilePictureUrl ?? "",
                                    placeholder: (context, url) => const CircularProgressIndicator(),
                                    errorWidget: (context, url, error) => const Icon(Icons.error),
                                  ),
                                ),
                              ),
                              title: Text(transactionHistoryController.combinedUniqueUserDataList[index].userId ?? ""),
                              trailing: const Icon(Icons.arrow_forward),
                              onTap: () {
                                _userAccountNoTEController.text = transactionHistoryController.combinedUniqueUserDataList[index].userId!;
                              },
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
                Row(
                  children: [
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 18),
                      child: GetBuilder<UserExistenceCheckController>(builder: (userExistenceCheckController) {
                        if (userExistenceCheckController.inProgress) {
                          return const Row(
                            children: [
                              CircularProgressIndicator(),
                              SizedBox(width: 60),
                            ],
                          );
                        }
                        return ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            fixedSize: const Size.fromWidth(150),
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
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              bool userExist = await userExistenceCheckController.checkUserExistence(_userAccountNoTEController.text);
                              if (userExist) {
                                Get.off(() => ReceiverAccountInformationScreen(userAccountId: _userAccountNoTEController.text.trim()));
                              } else {
                                SnackBarMessage.snackbarMessage(
                                  title: "Invalid User Id",
                                  message: "User Not Exist",
                                  type: false,
                                );
                              }
                            }
                          },
                          child: const Text("Next"),
                        );
                      }),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _userAccountNoTEController.dispose();
    super.dispose();
  }
}
