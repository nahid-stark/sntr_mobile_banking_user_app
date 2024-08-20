import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:sntr_mobile_banking_user_app/data/account_creation_user_data.dart';
import 'package:sntr_mobile_banking_user_app/data/date_and_time.dart';
import 'package:sntr_mobile_banking_user_app/model/send_user_data_to_server_model.dart';

class StoreUserAccountInfoOnPendingController extends GetxController {
  Future<String> sendUserDataToPendingServer() async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    AccountCreationUserData.accountUserId = _generateUserAccountId(
      firstName: AccountCreationUserData.firstName,
      lastName: AccountCreationUserData.lastName,
    );
    AccountCreationUserData.creationDate = DateAndTime.getCurrentDateAndTime();
    final SendUserDataToServerModel dataToServerModel = SendUserDataToServerModel();
    await firestore
        .collection("pending_accounts")
        .doc(AccountCreationUserData.accountUserId)
        .set(dataToServerModel.textualDataModel);
    Reference profilePictureStorageRef = FirebaseStorage.instance
        .ref()
        .child("pending_accounts")
        .child(AccountCreationUserData.accountUserId)
        .child("profilePicture");
    Reference nidFrontSidePictureStorageRef = FirebaseStorage.instance
        .ref()
        .child("pending_accounts")
        .child(AccountCreationUserData.accountUserId)
        .child("nidFrontSidePicture");
    Reference nidBackSidePictureStorageRef = FirebaseStorage.instance
        .ref()
        .child("pending_accounts")
        .child(AccountCreationUserData.accountUserId)
        .child("nidBackSidePicture");
    await profilePictureStorageRef.putFile(dataToServerModel.profilePicture!);
    await nidFrontSidePictureStorageRef.putFile(dataToServerModel.nidFrontSide!);
    await nidBackSidePictureStorageRef.putFile(dataToServerModel.nidBackSide!);
    await sendUserDataToMainServer();
    return AccountCreationUserData.accountUserId;
  }

  Future<void> sendUserDataToMainServer() async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final SendUserDataToServerModel dataToServerModel = SendUserDataToServerModel();
    await firestore
        .collection("user_info")
        .doc(AccountCreationUserData.accountUserId)
        .set(dataToServerModel.textualDataModel);
    Reference profilePictureStorageRef = FirebaseStorage.instance
        .ref()
        .child("user_info")
        .child(AccountCreationUserData.accountUserId)
        .child("profilePicture");
    Reference nidFrontSidePictureStorageRef = FirebaseStorage.instance
        .ref()
        .child("user_info")
        .child(AccountCreationUserData.accountUserId)
        .child("nidFrontSidePicture");
    Reference nidBackSidePictureStorageRef = FirebaseStorage.instance
        .ref()
        .child("user_info")
        .child(AccountCreationUserData.accountUserId)
        .child("nidBackSidePicture");
    await profilePictureStorageRef.putFile(dataToServerModel.profilePicture!);
    await nidFrontSidePictureStorageRef.putFile(dataToServerModel.nidFrontSide!);
    await nidBackSidePictureStorageRef.putFile(dataToServerModel.nidBackSide!);
  }

  String _generateUserAccountId({int length = 7, required String firstName, required String lastName}) {
    const characters = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    Random random = Random();
    return firstName +
        String.fromCharCodes(
          Iterable.generate(
            length,
            (_) {
              int codeUnit = characters.codeUnitAt(random.nextInt(characters.length));
              return codeUnit;
            },
          ),
        ) +
        lastName;
  }
}
