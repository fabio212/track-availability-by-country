import 'dart:convert';

import 'package:track_availability_by_country/services/base.dart';

abstract class BaseSpotifyAuth extends Base {
  @override
  Future<Map<String, String>> baseHeader() async {
    String credentials = '6542871f20064d989c97753df4cb25e4:a065d8f09c3a4ab9b3c379eaf2ccc436';
    Codec<String, String> stringToBase64 = utf8.fuse(base64);
    String auth = stringToBase64.encode(credentials);
    return {
      'Authorization': 'Basic $auth',
      'Content-Type': 'application/x-www-form-urlencoded'
    };
  }

  @override
  String baseUrl() {
    return 'https://accounts.spotify.com';
  }
}
