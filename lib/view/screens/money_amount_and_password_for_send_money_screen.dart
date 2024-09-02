import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sntr_mobile_banking_user_app/controller/send_money_controller.dart';
import 'package:sntr_mobile_banking_user_app/data/logged_in_user_data.dart';
import 'package:sntr_mobile_banking_user_app/view/widgets/snackbar_message.dart';

class MoneyAmountAndPasswordForSendMoneyScreen extends StatefulWidget {
  const MoneyAmountAndPasswordForSendMoneyScreen({super.key, required this.receiverUserId});

  final String receiverUserId;

  @override
  State<MoneyAmountAndPasswordForSendMoneyScreen> createState() => _MoneyAmountAndPasswordForSendMoneyScreenState();
}

class _MoneyAmountAndPasswordForSendMoneyScreenState extends State<MoneyAmountAndPasswordForSendMoneyScreen> {
  final TextEditingController _sendAmountTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Send Money"),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const Text(
                  "Send Amount",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w600,
                    color: Colors.green,
                  ),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: TextFormField(
                    controller: _sendAmountTEController,
                    keyboardType: TextInputType.number,
                    validator: (String? value) {
                      if (value?.isEmpty ?? true) {
                        return "Enter Send Amount";
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      hintText: "Send Amount",
                      labelText: "Send Amount",
                      prefixText: "৳  ",
                      prefixStyle: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.green,
                      ),
                    ),
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 24
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  "Password",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w600,
                    color: Colors.green,
                  ),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: TextFormField(
                    controller: _passwordTEController,
                    validator: (String? value) {
                      if (value?.isEmpty ?? true) {
                        return "Enter Your Password";
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      hintText: "Password",
                      labelText: "Password",
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 24, right: 36, bottom: 24, top: 24),
                  child: GetBuilder<SendMoneyController>(builder: (sendMoneyController) {
                    return GetBuilder<SendMoneyController>(
                      builder: (sendMoneyController) {
                        if(sendMoneyController.inProgress) {
                          return const Center(child: CircularProgressIndicator());
                        }
                        return ElevatedButton(
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
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              if (int.parse(_sendAmountTEController.text) > 0) {
                                if (int.parse(_sendAmountTEController.text) <= LoggedInUserData.accountBalance) {
                                  if(_passwordTEController.text.trim() == LoggedInUserData.password) {
                                    bool result = await sendMoneyController.sendMoney(widget.receiverUserId, _sendAmountTEController.text.trim());
                                    if(result) {
                                      Get.back();
                                    } else {
                                      SnackBarMessage.snackbarMessage(
                                        title: "Operation Failed",
                                        message: "Something Wrong",
                                        type: false,
                                      );
                                    }
                                  } else {
                                    SnackBarMessage.snackbarMessage(
                                      title: "Incorrect Password",
                                      message: "Wrong Password",
                                      type: false,
                                    );
                                  }
                                } else {
                                  SnackBarMessage.snackbarMessage(
                                    title: "Invalid Amount",
                                    message: "Not Enough Money",
                                    type: false,
                                  );
                                }
                              } else {
                                SnackBarMessage.snackbarMessage(
                                  title: "Invalid Amount",
                                  message: "Amount Can't Be Less Than One",
                                  type: false,
                                );
                              }
                              /*
                                1. check the sender balance(done)
                                2. change sender balance
                                3. change receiver balance
                                4. change transaction history for sender
                                5. change transaction history for receiver
                                 */
                            }
                          },
                          child: const Text("Send"),
                        );
                      }
                    );
                  }),
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
    _sendAmountTEController.dispose();
    _passwordTEController.dispose();
    super.dispose();
  }
}
