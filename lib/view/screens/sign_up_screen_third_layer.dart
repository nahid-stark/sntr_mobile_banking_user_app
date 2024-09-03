import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sntr_mobile_banking_user_app/data/account_creation_user_data.dart';
import 'package:sntr_mobile_banking_user_app/view/screens/sign_up_screen_fourth_layer.dart';
import 'package:sntr_mobile_banking_user_app/view/widgets/app_logo.dart';

class SignUpScreenThirdLayer extends StatefulWidget {
  const SignUpScreenThirdLayer({super.key});

  @override
  State<SignUpScreenThirdLayer> createState() => _SignUpScreenThirdLayerState();
}

class _SignUpScreenThirdLayerState extends State<SignUpScreenThirdLayer> {
  File? profileImage;
  final ImagePicker imagePicker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                const AppLogo(),
                const SizedBox(height: 12),
                const Text(
                  "Your Profile Picture",
                  style: TextStyle(fontWeight: FontWeight.w600, color: Colors.green, fontSize: 24),
                ),
                const SizedBox(height: 12),
                CircleAvatar(
                  radius: 120,
                  child: profileImage == null
                      ? ClipOval(
                          child: Image.asset(
                            "assets/icons/user.png",
                            width: 240,
                            height: 240,
                            fit: BoxFit.fill,
                          ),
                        )
                      : ClipOval(
                          child: Image.file(
                            profileImage!,
                            width: 240,
                            height: 240,
                            fit: BoxFit.fill,
                          ),
                        ),
                ),
                const SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        fixedSize: const Size.fromWidth(150),
                        padding: const EdgeInsets.symmetric(vertical: 2),
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
                        _imagePicker("camera");
                      },
                      child: Image.asset(
                        "assets/icons/camera_icon.png",
                        height: 40,
                        width: 40,
                        color: Colors.white,
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        fixedSize: const Size.fromWidth(150),
                        padding: const EdgeInsets.symmetric(vertical: 2),
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
                        _imagePicker("gallery");
                      },
                      child: Image.asset(
                        "assets/icons/gallery_icon.png",
                        height: 40,
                        width: 40,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 70),
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
                  onPressed: profileImage == null
                      ? null
                      : () {
                          AccountCreationUserData.profilePicture = profileImage!;
                          Get.to(() => const SignUpScreenFourthLayer());
                        },
                  child: const Text("Next"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _imagePicker(String mode) async {
    final XFile? pickedImage = await imagePicker.pickImage(source: mode == "camera" ? ImageSource.camera : ImageSource.gallery);
    if (pickedImage != null) {
      profileImage = File(pickedImage.path);
      setState(() {});
    }
  }
}
