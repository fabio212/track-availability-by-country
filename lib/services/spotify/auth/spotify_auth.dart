import 'dart:convert';

import '../../local_storage.dart';
import '/models/auth.dart';
import 'base_spotify_auth.dart';

class SpotifyAuth extends BaseSpotifyAuth {
  Future<Auth> execute() async {
    var response = await post('/api/token', { 'grant_type': 'client_credentials' });
    final Map json = jsonDecode(response.body);
    Auth auth = Auth(accessToken: json['access_token']);
    LocalStorage().add('SPOTIFY_ACCESS_TOKEN', auth.accessToken);
    return auth;
  }
}
