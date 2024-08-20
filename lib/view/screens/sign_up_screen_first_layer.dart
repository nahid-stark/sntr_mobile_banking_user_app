import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sntr_mobile_banking_user_app/view/screens/sign_up_screen_second_layer.dart';
import 'package:sntr_mobile_banking_user_app/view/widgets/app_logo.dart';

class SignUpScreenFirstLayer extends StatefulWidget {
  const SignUpScreenFirstLayer({super.key});

  @override
  State<SignUpScreenFirstLayer> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreenFirstLayer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const AppLogo(),
              const SizedBox(height: 12),
              const Text(
                "Create Account",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.green,
                  fontSize: 32,
                ),
              ),
              const SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28),
                child: ElevatedButton(
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
                  onPressed: (){
                    Get.to(() => const SignUpScreenSecondLayer());
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Get Started"),
                      Icon(Icons.arrow_forward_rounded),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
