import 'package:sntr_mobile_banking_user_app/model/transaction_data.dart';

class TransactionModel {
  List<TransactionData> transactionList = <TransactionData>[];

  TransactionModel.fromJson(Map<String, dynamic> transactionHistory, List<String> transactionIdList) {
    for(int index = 0; index < transactionIdList.length; index++) {
      transactionList.add(
        TransactionData.fromJson(
          transactionHistory[transactionIdList[index]],
          transactionIdList[index],
        ),
      );
    }
  }
}
