class DateAndTime {
  static String getCurrentDateAndTime () {
    DateTime now = DateTime.now();
    return "${now.toLocal().toString().split(' ')[0]} ${now.hour}:${now.minute}:${now.second}";
  }
}
