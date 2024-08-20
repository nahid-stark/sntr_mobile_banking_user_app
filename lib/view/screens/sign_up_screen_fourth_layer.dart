import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sntr_mobile_banking_user_app/data/account_creation_user_data.dart';
import 'package:sntr_mobile_banking_user_app/view/screens/sign_up_screen_fifth_layer.dart';
import 'package:sntr_mobile_banking_user_app/view/widgets/app_logo.dart';

class SignUpScreenFourthLayer extends StatefulWidget {
  const SignUpScreenFourthLayer({super.key});

  @override
  State<SignUpScreenFourthLayer> createState() => _SignUpScreenFourthLayerState();
}

class _SignUpScreenFourthLayerState extends State<SignUpScreenFourthLayer> {
  File? frontSideOfNID;
  File? backSideOfNID;
  final ImagePicker imagePicker = ImagePicker();
  bool nextButtonAllowed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const AppLogo(),
              const SizedBox(height: 8),
              const Text(
                "Complete Picture Of Your NID Card",
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              _buildFrontPictureTitleAndButton(),
              Container(
                height: 180,
                width: 280,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: Colors.orange,
                    width: 2,
                  ),
                ),
                child: frontSideOfNID == null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          "assets/icons/id_card_front_side.png",
                          color: Colors.grey,
                          fit: BoxFit.fill,
                        ),
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.file(
                          frontSideOfNID!,
                          fit: BoxFit.fill,
                        ),
                      ),
              ),
              _buildBackPictureTitleAndButton(),
              Container(
                height: 180,
                width: 280,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: Colors.orange,
                    width: 2,
                  ),
                ),
                child: backSideOfNID == null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          "assets/icons/id_card_back_side.png",
                          color: Colors.grey,
                          fit: BoxFit.contain,
                        ),
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.file(
                          backSideOfNID!,
                          fit: BoxFit.fill,
                        ),
                      ),
              ),
              const SizedBox(height: 4),
              _buildNextButton(),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _pickImage(int nidSide) async {
    final XFile? pickedImage = await imagePicker.pickImage(source: ImageSource.camera);
    if (pickedImage != null) {
      switch (nidSide) {
        case 1:
          frontSideOfNID = File(pickedImage.path);
          break;
        case 2:
          backSideOfNID = File(pickedImage.path);
          break;
      }
      setState(() {});
      await Future.delayed(const Duration(seconds: 5));
      (frontSideOfNID == null || backSideOfNID == null) ? nextButtonAllowed = false : nextButtonAllowed = true;
      setState(() {});
    }
  }

  Widget _buildNextButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 36),
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
        onPressed: nextButtonAllowed
            ? () {
                AccountCreationUserData.nidFrontSide = frontSideOfNID!;
                AccountCreationUserData.nidBackSide = backSideOfNID!;
                Get.to(() => const SignUpScreenFifthLayer());
              }
            : null,
        child: const Text("Next"),
      ),
    );
  }

  Widget _buildBackPictureTitleAndButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
      child: Row(
        children: [
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Back Side of Your NID card",
                style: TextStyle(color: Colors.black54, fontSize: 16),
              ),
              Text(
                "(LandScape)",
                style: TextStyle(color: Colors.black54, fontSize: 16),
              ),
            ],
          ),
          const SizedBox(width: 20),
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
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                textStyle: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ),
              onPressed: () {
                _pickImage(2);
              },
              child: const Text("Take Picture"),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFrontPictureTitleAndButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
      child: Row(
        children: [
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Front Side of Your NID card",
                style: TextStyle(color: Colors.black54, fontSize: 16),
              ),
              Text(
                "(LandScape)",
                style: TextStyle(color: Colors.black54, fontSize: 16),
              ),
            ],
          ),
          const SizedBox(width: 20),
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
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                textStyle: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ),
              onPressed: () {
                _pickImage(1);
              },
              child: const Text("Take Picture"),
            ),
          ),
        ],
      ),
    );
  }
}
