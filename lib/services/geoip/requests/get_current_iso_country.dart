import 'dart:convert';

import 'package:track_availability_by_country/services/geoip/requests/base_geo_ip.dart';

class GetCurrentIsoCountry extends BaseGeoIp {
  final String _apiKey = 'b8568cb9afc64fad861a69edbddb2658';

  Future<String> execute() async {
    var response = await get('/ipinfo?apiKey=$_apiKey');
    final Map mapJson = jsonDecode(response.body);
    if (mapJson['country'] == null) {
      return '';
    }
    return mapJson['country']["iso_code"];
  }
}
