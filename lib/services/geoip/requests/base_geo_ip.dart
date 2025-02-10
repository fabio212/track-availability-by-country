import '/services/base.dart';

abstract class BaseGeoIp extends Base {
  @override
  String baseUrl() {
    return 'https://api.geoapify.com/v1';
  }
  @override
  Future<Map<String, String>> baseHeader() async {
    return {};
  }
}
