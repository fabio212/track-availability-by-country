import '../services/local_storage.dart';

class Countries {
  static void saveLastCountrySelected(String country) {
    LocalStorage().add('LAST_COUNTRY_SELECTED', country);
  }

  static Future<String> getLastCountrySelected() async {
    return await LocalStorage().read('LAST_COUNTRY_SELECTED');
  }
}
