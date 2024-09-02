import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sntr_mobile_banking_user_app/controller/transaction_history_controller.dart';
import 'package:sntr_mobile_banking_user_app/model/second_person_data.dart';
import 'package:sntr_mobile_banking_user_app/model/transaction_data.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({super.key});

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  @override
  void initState() {
    Get.find<TransactionHistoryController>().getUserTransactionHistory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Transactions"),
      ),
      body: GetBuilder<TransactionHistoryController>(builder: (transactionHistoryController) {
        if (transactionHistoryController.inProgress) {
          return const Center(child: CircularProgressIndicator());
        }
        return ListView.builder(
          itemCount: transactionHistoryController.transactionDataList.length,
          itemBuilder: (context, index) {
            return _buildListItem(
              transactionHistoryController.transactionDataList[index],
              transactionHistoryController.secondPersonDataList[index],
            );
          },
        );
      }),
    );
  }

  Widget _buildListItem(TransactionData transactionInfo, SecondPersonData secondPersonInfo) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Card(
        elevation: 7,
        child: Row(
          children: [
            const SizedBox(width: 4),
            _buildSecondPersonProfilePicture(secondPersonInfo.profilePictureUrl ?? ""),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Status : ${transactionInfo.transactionStatus}",
                  style: const TextStyle(fontSize: 18),
                ),
                Text(
                  "Transaction Id : ${transactionInfo.transactionId}",
                  style: const TextStyle(fontSize: 18),
                ),
                Text(
                  "Date : ${transactionInfo.transactionDate}",
                  style: const TextStyle(fontSize: 18),
                ),
                Text(
                  "Amount : ${transactionInfo.transactionAmount}",
                  style: const TextStyle(fontSize: 18),
                ),
                transactionInfo.transactionStatus == "send"
                    ? Text("Receiver Id : ${secondPersonInfo.accountUserId}")
                    : Text("Sender Id : ${secondPersonInfo.accountUserId}"),
                transactionInfo.transactionStatus == "send"
                    ? Text("Receiver Name : ${secondPersonInfo.firstName} ${secondPersonInfo.lastName}")
                    : Text("Sender Name : ${secondPersonInfo.firstName} ${secondPersonInfo.lastName}"),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSecondPersonProfilePicture(String profilePictureUrl) {
    return CircleAvatar(
      radius: 30,
      child: ClipOval(
        child: CachedNetworkImage(
          imageUrl: profilePictureUrl,
          placeholder: (context, url) => const CircularProgressIndicator(),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
      ),
    );
  }
}
