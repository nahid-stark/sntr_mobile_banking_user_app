import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sntr_mobile_banking_user_app/view/screens/login_screen.dart';
import 'package:sntr_mobile_banking_user_app/view/widgets/app_logo.dart';

class AccountCreationCompleteScreen extends StatefulWidget {
  const AccountCreationCompleteScreen({super.key, required this.userAccountNo});

  final String userAccountNo;

  @override
  State<AccountCreationCompleteScreen> createState() => _AccountCreationCompleteScreenState();
}

class _AccountCreationCompleteScreenState extends State<AccountCreationCompleteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const Spacer(),
            const AppLogo(),
            const SizedBox(height: 18),
            const Text(
              "Your Account Creation Request Complete!",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 18,
                color: Colors.green,
              ),
            ),
            const SizedBox(height: 18),
            Text(
              "Your Account ID is\n${widget.userAccountNo}",
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 18,
                color: Colors.green,
              ),
            ),
            const SizedBox(height: 18),
            const Text(
              "Our Agent Will Verify Your Information's and Approve Your Account Creation Request. This May Take 6 - 12 Hour.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 18),
            const Text(
              "Please Wait !!",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                color: Colors.black54,
              ),
            ),
          const SizedBox(height: 18),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              fixedSize: const Size.fromWidth(150),
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
              Get.to(() => const LoginScreen());
            },
            child: const Text("Okay"),
          ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
