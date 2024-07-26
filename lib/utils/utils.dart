class Utils {
  static DateTime parseStringDate(String stringDate) {
    if (stringDate.length == 4 && !stringDate.contains('-')) {
      return DateTime(int.parse(stringDate));
    } else if (stringDate.length == 7) {
      return DateTime.parse('$stringDate-01');
    } else if (stringDate.length == 10) {
      return DateTime.parse(stringDate);
    } else {
      return DateTime.now();
    }
  }
}
