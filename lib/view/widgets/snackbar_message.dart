import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SnackBarMessage {
  static void snackbarMessage({required String title, required String message, required bool type}) {
    Get.snackbar(
      "",
      "",
      titleText: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Text(
          title,
          style: const TextStyle(
            color: Colors.greenAccent,
            fontWeight: FontWeight.w600,
            fontSize: 24,
          ),
        ),
      ),
      messageText: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Text(
          message,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white),
        ),
      ),
      animationDuration: const Duration(milliseconds: 500),
      backgroundColor: Colors.black54,
      borderRadius: 4,
      margin: const EdgeInsets.only(top: 12, left: 4, right: 40),
      padding: const EdgeInsets.symmetric(vertical: 4),
      duration: const Duration(seconds: 3),
      snackPosition: SnackPosition.TOP,
      leftBarIndicatorColor: type ? Colors.green : Colors.red,
    );
  }
}
