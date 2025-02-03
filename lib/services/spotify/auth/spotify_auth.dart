import 'dart:convert';

import '../../local_storage.dart';
import '/models/auth.dart';
import 'base_spotify_auth.dart';

class SpotifyAuth extends BaseSpotifyAuth {
  Future<Auth> execute() async {
    String accessToken = await LocalStorage().read('SPOTIFY_ACCESS_TOKEN');

    if (accessToken.isEmpty) {
      return _refreshToken();
    } else {
      String expiresInSeconds = await LocalStorage().read('SPOTIFY_ACCESS_TOKEN_EXPIRES_IN');

      if (expiresInSeconds.isEmpty) {
        return _refreshToken();
      }

      DateTime expiresAt = DateTime.parse(expiresInSeconds);

      if (expiresAt.isBefore(DateTime.now())) {
        return _refreshToken();
      }

      return Auth(accessToken: accessToken, expiresAt: expiresAt);
    }
  }

  Future<Auth> _refreshToken() async {
    var response = await post('/api/token', { 'grant_type': 'client_credentials' });
    final Map json = jsonDecode(response.body);
    int expiresInSeconds = json['expires_in'];
    DateTime expiresAt = DateTime.now().add(Duration(seconds: expiresInSeconds));
    Auth auth = Auth(accessToken: json['access_token'], expiresAt: expiresAt);
    await LocalStorage().add('SPOTIFY_ACCESS_TOKEN', auth.accessToken);
    await LocalStorage().add('SPOTIFY_ACCESS_TOKEN_EXPIRES_IN', auth.expiresAt.toString());
    return auth;
  }
}
