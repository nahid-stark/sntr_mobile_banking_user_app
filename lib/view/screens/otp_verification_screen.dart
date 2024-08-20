import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:sntr_mobile_banking_user_app/view/screens/sign_up_screen_sixth_layer.dart';
import 'package:sntr_mobile_banking_user_app/view/widgets/app_logo.dart';
import 'package:sntr_mobile_banking_user_app/view/widgets/snackbar_message.dart';

class OtpVerificationScreen extends StatefulWidget {
  const OtpVerificationScreen({super.key, required this.email});

  final String email;

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final TextEditingController _otpTEController = TextEditingController();
  RxInt resendOtpCodeTimerCounterValue = 120.obs;
  RxBool isOtpCodeExpired = false.obs;
  String otp = "";

  @override
  void initState() {
    super.initState();
    expireOtpCodeTimerController();
    _sendOTP();
  }

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
                "An 6 Digit OTP Has Been Send To This Email",
                style: TextStyle(color: Colors.black54, fontSize: 17),
              ),
              Text(
                widget.email,
                style: const TextStyle(
                  color: Colors.green,
                  fontSize: 19,
                ),
              ),
              const SizedBox(height: 18),
              _buildPinField(),
              const SizedBox(height: 12),
              buildNextButton(),
              const SizedBox(height: 28),
              Obx(
                () => _buildResendCodeMessage(),
              ),
              Obx(
                () => _buildResendCodeButton(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _generateOTP() {
    Random randomNUmber = Random();
    otp = (randomNUmber.nextInt(899999) + 100000).toString();
    return otp;
  }

  void _sendOTP() async {
    String email = widget.email;
    String otp = _generateOTP();
    await _sendOTPByEmail(email, otp);
  }

  Future<void> _sendOTPByEmail(String recipientEmail, String otp) async {
    const String username = 'sntrbankinglimited@gmail.com';
    const String password = 'ubev meix tlyk ynak';
    final SmtpServer smtpServer = gmail(username, password);
    final Message message = Message()
      ..from = const Address(username, "SNTR Banking Limited")
      ..recipients.add(recipientEmail)
      ..subject = "Your Email Verification OTP"
      ..text = "Your OTP is : $otp";

    try {
      await send(message, smtpServer);
    } catch (error) {
      SnackBarMessage.snackbarMessage(title: "Otp Sending Failed", message: "Something went Wrong", type: false);
    }
  }

  Widget buildNextButton() {
    return ElevatedButton(
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
        if(otp == _otpTEController.text) {
          Get.to(() => const SignUpScreenSixthLayer());
        } else {
          SnackBarMessage.snackbarMessage(title: "Wrong OTP", message: "Enter Correct Otp", type: false);
        }
      },
      child: const Text("Next"),
    );
  }

  Widget _buildPinField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: PinCodeTextField(
        length: 6,
        keyboardType: TextInputType.number,
        obscureText: false,
        autoDisposeControllers: false,
        showCursor: true,
        cursorColor: Colors.purple,
        cursorWidth: 3,
        animationType: AnimationType.fade,
        pinTheme: PinTheme(
          shape: PinCodeFieldShape.box,
          borderRadius: BorderRadius.circular(5),
          fieldHeight: 50,
          fieldWidth: 40,
          activeFillColor: Colors.white,
          inactiveFillColor: Colors.transparent,
          selectedFillColor: Colors.white,
          inactiveColor: Colors.green,
          selectedColor: Colors.blue,
        ),
        animationDuration: const Duration(milliseconds: 300),
        enableActiveFill: true,
        controller: _otpTEController,
        appContext: context,
      ),
    );
  }

  Widget _buildResendCodeButton() {
    return TextButton(
      onPressed: isOtpCodeExpired.value
          ? () {
              resendOtpCodeTimerCounterValue.value = 120;
              expireOtpCodeTimerController();
              isOtpCodeExpired.value = false;
              _sendOTP();
            }
          : null,
      child: Text(
        "Resend Code",
        style: TextStyle(
          color: isOtpCodeExpired.value ? Colors.purple : Colors.blueGrey,
          fontSize: 18,
        ),
      ),
    );
  }

  Widget _buildResendCodeMessage() {
    return RichText(
      text: TextSpan(
        children: [
          const TextSpan(
            text: "This code will expire in ",
            style: TextStyle(
              color: Colors.black54,
              fontSize: 18,
            ),
          ),
          TextSpan(
            text: "${resendOtpCodeTimerCounterValue.value} s",
            style: const TextStyle(
              color: Colors.green,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> expireOtpCodeTimerController() async {
    while (resendOtpCodeTimerCounterValue > 0) {
      await Future.delayed(const Duration(seconds: 1));
      resendOtpCodeTimerCounterValue--;
    }
    isOtpCodeExpired.value = true;
  }

  @override
  void dispose() {
    _otpTEController.dispose();
    super.dispose();
  }
}
