import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sntr_mobile_banking_user_app/data/account_creation_user_data.dart';
import 'package:sntr_mobile_banking_user_app/view/screens/sign_up_screen_third_layer.dart';
import 'package:sntr_mobile_banking_user_app/view/widgets/app_logo.dart';

class SignUpScreenSecondLayer extends StatefulWidget {
  const SignUpScreenSecondLayer({super.key});

  @override
  State<SignUpScreenSecondLayer> createState() => _SignUpScreenSecondLayerState();
}

class _SignUpScreenSecondLayerState extends State<SignUpScreenSecondLayer> {
  final TextEditingController _firstNameTEController = TextEditingController();
  final TextEditingController _lastNameTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const AppLogo(),
                  const SizedBox(height: 12),
                  const Text(
                    "Your Name",
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 28,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    keyboardType: TextInputType.name,
                    validator: (String? value) {
                      if (value?.isEmpty ?? true) {
                        return "Enter Your First Name";
                      }
                      return null;
                    },
                    controller: _firstNameTEController,
                    decoration: const InputDecoration(
                      hintText: "Enter Your First Name",
                      labelText: "Enter Your First Name",
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    keyboardType: TextInputType.name,
                    validator: (String? value) {
                      if (value?.isEmpty ?? true) {
                        return "Enter Your Last Name";
                      }
                      return null;
                    },
                    controller: _lastNameTEController,
                    decoration: const InputDecoration(
                      hintText: "Enter Your Last Name",
                      labelText: "Enter Your Last Name",
                    ),
                  ),
                  const SizedBox(height: 26),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      fixedSize: const Size.fromWidth(double.maxFinite),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      textStyle: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 20,
                      ),
                    ),
                    onPressed: () {
                      if(_formKey.currentState!.validate()) {
                        AccountCreationUserData.firstName = _firstNameTEController.text.trim();
                        AccountCreationUserData.lastName = _lastNameTEController.text.trim();
                        Get.to(() => const SignUpScreenThirdLayer());
                      }
                    },
                    child: const Text("Next"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _firstNameTEController.dispose();
    _lastNameTEController.dispose();
    super.dispose();
  }
}
