import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:sntr_mobile_banking_user_app/data/logged_in_user_data.dart';
import 'package:sntr_mobile_banking_user_app/model/second_person_data.dart';
import 'package:sntr_mobile_banking_user_app/model/transaction_data.dart';
import 'package:sntr_mobile_banking_user_app/model/transaction_model.dart';
import 'package:sntr_mobile_banking_user_app/model/unique_id_and_profile_for_recent_transaction.dart';

class TransactionHistoryController extends GetxController {
  bool get inProgress => _inProgress;
  List<TransactionData> get transactionDataList => _transactionDataList;
  List<SecondPersonData> get secondPersonDataList => _secondPersonDataList;
  List<UniqueIdAndProfileForRecentTransaction> get combinedUniqueUserDataList => _combinedUniqueDataSet;
  bool _inProgress = false;
  List<TransactionData> _transactionDataList = <TransactionData>[];
  final List<SecondPersonData> _secondPersonDataList = <SecondPersonData>[];
  List<String> _uniqueName = <String>[];
  List<String> _uniqueProfilePicture = <String>[];
  final List<UniqueIdAndProfileForRecentTransaction> _combinedUniqueDataSet = <UniqueIdAndProfileForRecentTransaction>[];

  Future<bool> getUserTransactionHistory() async {
    late bool isSuccess = true;
    _inProgress = true;
    update();
    final FirebaseFirestore firebaseFirestoreInstance = FirebaseFirestore.instance;
    DocumentSnapshot transactionIdListData = await firebaseFirestoreInstance.collection("transactionIdList").doc(LoggedInUserData.userAccount).get();
    if(transactionIdListData.data() == null) {
      _inProgress = false;
      update();
      return false;
    }
    DocumentSnapshot transactionHistory = await firebaseFirestoreInstance.collection("transactions").doc(LoggedInUserData.userAccount).get();
    List<dynamic> transactionIdList = (transactionIdListData.get("transactionId"));
    _transactionDataList = TransactionModel.fromJson(
      transactionHistory.data() as Map<String, dynamic>,
      transactionIdList.cast<String>(),
    ).transactionList;
    await _getSecondPersonData();
    _inProgress = false;
    update();
    return isSuccess;
  }

  Future<bool> _getSecondPersonData() async {
    late bool isSuccess = true;
    final FirebaseFirestore firebaseFirestoreInstance = FirebaseFirestore.instance;
    _secondPersonDataList.clear();
    for (int index = 0; index < _transactionDataList.length; index++) {
      DocumentSnapshot userDocSnapshot = await firebaseFirestoreInstance
          .collection("user_info")
          .doc(
            _transactionDataList[index].transactionStatus == "send" ? _transactionDataList[index].receiverId : _transactionDataList[index].senderId,
          )
          .get();
      Reference profilePictureStorageRef = FirebaseStorage.instance.ref().child("user_info").child(
            _transactionDataList[index].transactionStatus == "send"
                ? _transactionDataList[index].receiverId!
                : _transactionDataList[index].senderId!,
          ).child("profilePicture");
      String profilePictureDownloadUrl = await profilePictureStorageRef.getDownloadURL();
      _secondPersonDataList.add(
        SecondPersonData.fromJson(userDocSnapshot.data() as Map<String, dynamic>, profilePictureDownloadUrl),
      );
    }
    _makeUniqueDataSet();
    return isSuccess;
  }
  void _makeUniqueDataSet() {
    _uniqueName.clear();
    _uniqueProfilePicture.clear();
    _combinedUniqueDataSet.clear();
    for(int index = 0; index < _secondPersonDataList.length; index++){
      _uniqueName.add(
        _secondPersonDataList[index].accountUserId!,
      );
      _uniqueProfilePicture.add(
        _secondPersonDataList[index].profilePictureUrl!,
      );
    }
    _uniqueName = _uniqueName.toSet().toList().reversed.toList();
    _uniqueProfilePicture = _uniqueProfilePicture.toSet().toList().reversed.toList();
    for(int index = 0; index < _uniqueName.length; index++) {
      _combinedUniqueDataSet.add(
        UniqueIdAndProfileForRecentTransaction.encapsulate(_uniqueName[index], _uniqueProfilePicture[index]),
      );
    }
  }
}
