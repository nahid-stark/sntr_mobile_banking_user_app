class TransactionData {
  String? transactionBy;
  String? senderId;
  String? receiverId;
  String? transactionAmount;
  String? transactionDate;
  String? transactionId;
  String? transactionStatus;

  TransactionData({
    this.transactionBy,
    this.senderId,
    this.receiverId,
    this.transactionAmount,
    this.transactionDate,
    this.transactionId,
  });

  TransactionData.fromJson(Map<String, dynamic> json, String trnId) {
    transactionId = trnId;
    senderId = json["sender"];
    receiverId = json["receiver"];
    transactionAmount = json["transactionAmount"];
    transactionDate = json["date"];
    transactionBy = json["transactionBy"];
    transactionStatus = json["transactionStatus"];
  }
}
