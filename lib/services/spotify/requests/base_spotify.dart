import 'package:track_availability_by_country/models/auth.dart';
import 'package:track_availability_by_country/services/local_storage.dart';

import '../auth/spotify_auth.dart';
import '/services/base.dart';

abstract class BaseSpotify extends Base {
  @override
  String baseUrl() {
    return 'https://api.spotify.com/v1';
  }
  @override
  Future<Map<String, String>> baseHeader() async {
    String accessToken = await _accessToken();
    return {
      'Authorization': 'Bearer $accessToken'
    };
  }

  Future<String> _accessToken() async {
    Auth auth = await SpotifyAuth().execute();
    return auth.accessToken;
  }
}
