import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sntr_mobile_banking_user_app/data/account_creation_user_data.dart';
import 'package:sntr_mobile_banking_user_app/view/screens/info_save_on_server_screen.dart';
import 'package:sntr_mobile_banking_user_app/view/widgets/app_logo.dart';
import 'package:sntr_mobile_banking_user_app/view/widgets/snackbar_message.dart';

class SignUpScreenSixthLayer extends StatefulWidget {
  const SignUpScreenSixthLayer({super.key});

  @override
  State<SignUpScreenSixthLayer> createState() => _SignUpScreenSixthLayerState();
}

class _SignUpScreenSixthLayerState extends State<SignUpScreenSixthLayer> {
  final TextEditingController _newPasswordTEController = TextEditingController();
  final TextEditingController _confirmPasswordTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _obscureTextEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const AppLogo(),
                const SizedBox(height: 18),
                const Text(
                  "Create A Strong Password",
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Text(
                  "Password Must Be At Least 8 Character",
                  style: TextStyle(color: Colors.black54, fontSize: 18),
                ),
                const SizedBox(height: 18),
                buildPasswordFields(),
                const SizedBox(height: 18),
                buildCompleteButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildPasswordFields() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          TextFormField(
            validator: (String? value) {
              if (value?.isEmpty ?? true) {
                return "Enter New Password";
              }
              return null;
            },
            controller: _newPasswordTEController,
            obscureText: _obscureTextEnabled,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              hintText: "New Password",
              labelText: "New Password",
              suffix: SizedBox(
                height: 30,
                child: IconButton(
                  padding: const EdgeInsets.all(0),
                  onPressed: () {
                    _obscureTextEnabled = !_obscureTextEnabled;
                    setState(() {});
                  },
                  icon: Icon(
                    _obscureTextEnabled ? Icons.visibility_off_outlined : Icons.remove_red_eye_outlined,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 26),
          TextFormField(
            validator: (String? value) {
              if (value?.isEmpty ?? true) {
                return "Enter Confirm Password";
              }
              return null;
            },
            controller: _confirmPasswordTEController,
            obscureText: _obscureTextEnabled,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              hintText: "Confirm Password",
              labelText: "Confirm Password",
              suffix: SizedBox(
                height: 30,
                child: IconButton(
                  padding: const EdgeInsets.all(0),
                  onPressed: () {
                    _obscureTextEnabled = !_obscureTextEnabled;
                    setState(() {});
                  },
                  icon: Icon(
                    _obscureTextEnabled ? Icons.visibility_off_outlined : Icons.remove_red_eye_outlined,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  ElevatedButton buildCompleteButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        fixedSize: const Size.fromWidth(300),
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
        if (_formKey.currentState!.validate()) {
          if (_newPasswordTEController.text == _confirmPasswordTEController.text) {
            AccountCreationUserData.password = _confirmPasswordTEController.text;
            Get.to(() => const InfoSaveOnServerScreen());
          } else {
            SnackBarMessage.snackbarMessage(
              title: "Password Don't Match",
              message: "New and Confirm Password Must Be Same",
              type: false,
            );
          }
        }
      },
      child: const Text("Complete"),
    );
  }

  @override
  void dispose() {
    _newPasswordTEController.dispose();
    _confirmPasswordTEController.dispose();
    super.dispose();
  }
}
