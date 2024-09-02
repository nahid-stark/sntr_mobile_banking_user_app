import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:sntr_mobile_banking_user_app/data/date_and_time.dart';
import 'package:sntr_mobile_banking_user_app/data/logged_in_user_data.dart';

class SendMoneyController extends GetxController {
  bool get inProgress => _inProgress;
  bool _inProgress = false;
  late bool _isSuccess;
  late String errorMessage;
  Future<bool> sendMoney(String receiverUserId, String amount) async {
    String transactionId = _generateTransactionId();
    String currentDateTime = DateAndTime.getCurrentDateAndTime();
    int senderCurrentBalance;
    int receiverCurrentBalance;
    int sendAmount;
    _inProgress = true;
    update();
    final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
      DocumentSnapshot<Map<String, dynamic>> senderData = await firebaseFirestore
          .collection("user_account_balance")
          .doc(LoggedInUserData.userAccount)
          .get();
      senderCurrentBalance = int.parse(senderData.get("balance"));
      DocumentSnapshot<Map<String, dynamic>> receiverData = await firebaseFirestore
          .collection("user_account_balance")
          .doc(receiverUserId)
          .get();
      receiverCurrentBalance = int.parse(receiverData.get("balance"));
      sendAmount = int.parse(amount);
    try {
      firebaseFirestore.collection("user_account_balance").doc(LoggedInUserData.userAccount).update(
        {
          "balance" : "${senderCurrentBalance - sendAmount}"
        }
      );
      firebaseFirestore.collection("user_account_balance").doc(receiverUserId).update(
          {
            "balance" : "${receiverCurrentBalance + sendAmount}"
          }
      );
      firebaseFirestore.collection("transactionIdList").doc(LoggedInUserData.userAccount).update(
        {
          "transactionId" : FieldValue.arrayUnion([transactionId]),
        }
      );
      firebaseFirestore.collection("transactionIdList").doc(receiverUserId).update(
          {
            "transactionId" : FieldValue.arrayUnion([transactionId]),
          }
      );
      firebaseFirestore.collection("transactions").doc(LoggedInUserData.userAccount).update(
        {
          transactionId : {
            "date" : currentDateTime,
            "receiver" : receiverUserId,
            "sender" : LoggedInUserData.userAccount,
            "transactionAmount" : amount,
            "transactionBy" : "user",
            "transactionStatus" : "send"
          }
        }
      );
      firebaseFirestore.collection("transactions").doc(receiverUserId).update(
          {
            transactionId : {
              "date" : currentDateTime,
              "receiver" : receiverUserId,
              "sender" : LoggedInUserData.userAccount,
              "transactionAmount" : amount,
              "transactionBy" : "user",
              "transactionStatus" : "receive"
            }
          }
      );
      _isSuccess = true;
    } catch(error) {
      _isSuccess = false;
      errorMessage = error.toString();
    }
    _inProgress = false;
    update();
    return _isSuccess;
  }

  String _generateTransactionId() {
    int length = 10;
    const characters = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    Random random = Random();
    return String.fromCharCodes(
      Iterable.generate(
        length,
            (_) {
          int codeUnit = characters.codeUnitAt(random.nextInt(characters.length));
          return codeUnit;
        },
      ),
    );
  }
}