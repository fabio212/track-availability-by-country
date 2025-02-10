import 'package:http/http.dart' as http;

abstract class Base {

  String baseUrl();
  Future<Map<String, String>> baseHeader();

  Future get(String url) async {
    Map<String, String> header = await baseHeader();
    return http.get(Uri.parse(baseUrl() + url), headers: header);
  }

  Future post(String url, Map body) async {
    Map<String, String> header = await baseHeader();
    return http.post(Uri.parse(baseUrl() + url), headers: header, body: body);
  }
}
