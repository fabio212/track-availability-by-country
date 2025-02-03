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

  static String minuteSecondFormat(Duration duration) {
    var minutes = duration.inMinutes.toString().padLeft(2, '0');
    var seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  static List<String> sortByAlphabeticOrder(List<String> list) {
    return list.toList()..sort();
  }

  static String pluralize(int count, String singular, String plural) {
    return count == 1 ? singular : plural;
  }
}
