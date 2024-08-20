class UniqueIdAndProfileForRecentTransaction {
  String? userId;
  String? profilePictureUrl;

  UniqueIdAndProfileForRecentTransaction({
    this.profilePictureUrl,
    this.userId,
  });
  UniqueIdAndProfileForRecentTransaction.encapsulate(String id, String url) {
    userId = id;
    profilePictureUrl = url;
  }
}
