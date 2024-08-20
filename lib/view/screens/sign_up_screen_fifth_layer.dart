import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sntr_mobile_banking_user_app/data/account_creation_user_data.dart';
import 'package:sntr_mobile_banking_user_app/view/screens/otp_verification_screen.dart';
import 'package:sntr_mobile_banking_user_app/view/widgets/app_logo.dart';

class SignUpScreenFifthLayer extends StatefulWidget {
  const SignUpScreenFifthLayer({super.key});

  @override
  State<SignUpScreenFifthLayer> createState() => _SignUpScreenFifthLayerState();
}

class _SignUpScreenFifthLayerState extends State<SignUpScreenFifthLayer> {
  String gender = "";
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _phoneTEController = TextEditingController();
  final TextEditingController _nidNoTEController = TextEditingController();
  final TextEditingController _postalCodeTEController = TextEditingController();
  final TextEditingController _addressTEController = TextEditingController();

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
                const SizedBox(height: 8),
                const Text(
                  "Provide Your Personal Information",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.green,
                    fontSize: 20,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                  child: Column(
                    children: [
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        validator: (String? value) {
                          if (value?.isEmpty ?? true) {
                            return "Enter Your Email";
                          }
                          return null;
                        },
                        controller: _emailTEController,
                        decoration: const InputDecoration(
                          hintText: "Enter Your Email",
                          labelText: "Enter Your Email",
                        ),
                      ),
                      const SizedBox(height: 18),
                      TextFormField(
                        keyboardType: TextInputType.phone,
                        validator: (String? value) {
                          if (value?.isEmpty ?? true) {
                            return "Enter Your Phone No.";
                          }
                          return null;
                        },
                        controller: _phoneTEController,
                        decoration: const InputDecoration(
                          hintText: "Enter Your Phone No.",
                          labelText: "Enter Your Phone No.",
                        ),
                      ),
                      const SizedBox(height: 18),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        validator: (String? value) {
                          if (value?.isEmpty ?? true) {
                            return "Enter Your NID No.";
                          }
                          return null;
                        },
                        controller: _nidNoTEController,
                        decoration: const InputDecoration(
                          hintText: "Enter Your NID No.",
                          labelText: "Enter Your NID No.",
                        ),
                      ),
                      const SizedBox(height: 18),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        validator: (String? value) {
                          if (value?.isEmpty ?? true) {
                            return "Enter Your Postal Code";
                          }
                          return null;
                        },
                        controller: _postalCodeTEController,
                        decoration: const InputDecoration(
                          hintText: "Enter Your Postal Code",
                          labelText: "Enter Your Postal Code",
                        ),
                      ),
                      const SizedBox(height: 18),
                      TextFormField(
                        keyboardType: TextInputType.streetAddress,
                        validator: (String? value) {
                          if (value?.isEmpty ?? true) {
                            return "Enter Your Complete Address";
                          }
                          return null;
                        },
                        controller: _addressTEController,
                        decoration: const InputDecoration(
                          hintText: "Enter Your Complete Address",
                          labelText: "Enter Your Complete Address",
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        "Select Gender",
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 25,
                            width: 90,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                fixedSize: const Size.fromWidth(18),
                                padding: const EdgeInsets.symmetric(vertical: 0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                backgroundColor: (gender == "" || gender == "Female") ? Colors.grey : Colors.green,
                                foregroundColor: Colors.white,
                                textStyle: const TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                ),
                              ),
                              onPressed: () {
                                gender = "Male";
                                setState(() {});
                              },
                              child: const Text("Male"),
                            ),
                          ),
                          const SizedBox(width: 40),
                          SizedBox(
                            height: 25,
                            width: 90,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                fixedSize: const Size.fromWidth(18),
                                padding: const EdgeInsets.symmetric(vertical: 0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                backgroundColor: (gender == "" || gender == "Male") ? Colors.grey : Colors.green,
                                foregroundColor: Colors.white,
                                textStyle: const TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                ),
                              ),
                              onPressed: () {
                                gender = "Female";
                                setState(() {});
                              },
                              child: const Text("FeMale"),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 36),
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
                        onPressed: gender == "" ? null : () {
                          if(_formKey.currentState!.validate()) {
                            AccountCreationUserData.email = _emailTEController.text.trim();
                            AccountCreationUserData.phoneNo = _phoneTEController.text.trim();
                            AccountCreationUserData.nidNo = _nidNoTEController.text.trim();
                            AccountCreationUserData.postalCode = _postalCodeTEController.text.trim();
                            AccountCreationUserData.address = _addressTEController.text.trim();
                            AccountCreationUserData.gender = gender;
                            Get.to(() => OtpVerificationScreen(email: _emailTEController.text.trim()));
                          }
                        },
                        child: const Text("Next"),
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

  ///TODO: check email by regex, look for duplicate email and nid no.

  @override
  void dispose() {
    _emailTEController.dispose();
    _phoneTEController.dispose();
    _nidNoTEController.dispose();
    _postalCodeTEController.dispose();
    _addressTEController.dispose();
    super.dispose();
  }
}
