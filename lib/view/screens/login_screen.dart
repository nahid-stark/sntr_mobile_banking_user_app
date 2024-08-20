import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sntr_mobile_banking_user_app/controller/user_login_controller.dart';
import 'package:sntr_mobile_banking_user_app/data/logged_in_user_data.dart';
import 'package:sntr_mobile_banking_user_app/view/screens/account_creation_complete_screen.dart';
import 'package:sntr_mobile_banking_user_app/view/screens/home_screen.dart';
import 'package:sntr_mobile_banking_user_app/view/screens/sign_up_screen_first_layer.dart';
import 'package:sntr_mobile_banking_user_app/view/widgets/app_logo.dart';
import 'package:sntr_mobile_banking_user_app/view/widgets/snackbar_message.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscureTextEnabled = true;
  final TextEditingController _userAccountNoTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
                const SizedBox(height: 12),
                const Text(
                  "Sign In",
                  style: TextStyle(fontSize: 38, fontWeight: FontWeight.w600, color: Colors.orange),
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.all(28),
                  child: Column(
                    children: [
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
                      TextFormField(
                        validator: (String? value) {
                          if (value?.isEmpty ?? true) {
                            return "Enter User Account Password";
                          }
                          return null;
                        },
                        controller: _passwordTEController,
                        obscureText: _obscureTextEnabled,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                          hintText: "Password",
                          labelText: "Password",
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
                      buildSignInButton(),
                      const SizedBox(height: 24),
                      const Text(
                        "Don't Have An Account?",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.black54,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Get.to(() => const SignUpScreenFirstLayer());
                        },
                        child: const Text(
                          "Sign Up",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.green,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildSignInButton() {
    return GetBuilder<UserLoginController>(
      builder: (userLoginController) {
        if(userLoginController.inProgress) {
          return const CircularProgressIndicator();
        }
        return ElevatedButton(
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
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              final bool isSuccess = await userLoginController.userLoginController(_userAccountNoTEController.text.trim());
              if(isSuccess) {
                if(userLoginController.userLoginDataModel.password == _passwordTEController.text.trim()) {
                  if(userLoginController.userLoginDataModel.accountOkay!) {
                    LoggedInUserData.userAccount = _userAccountNoTEController.text.trim();
                    LoggedInUserData.password = _userAccountNoTEController.text.trim();
                    Get.offAll(() => const HomeScreen());
                  } else {
                    Get.offAll(() => AccountCreationCompleteScreen(userAccountNo: _userAccountNoTEController.text.trim()));
                  }
                } else {
                  SnackBarMessage.snackbarMessage(title: "Wrong Password", message: "Give Correct Password", type: false);
                }
              } else {
                SnackBarMessage.snackbarMessage(title: "Wrong User Account ID", message: "No User Found For This Id", type: false);
              }
            }
          },
          child: const Text("Sign In"),
        );
      }
    );
  }
}
