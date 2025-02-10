import 'dart:convert';

import '../../../models/cover.dart';
import '../../../models/spotify.dart';
import '../../../utils/utils.dart';
import '/models/album.dart';

import '/models/artist.dart';
import '/models/track.dart';
import 'base_spotify.dart';

class SearchSpotifyTrack extends BaseSpotify {
  Future<List<Track>> searchTracks(String query, { String market = 'BR' }) async {
    if (query.contains('spotify:track:')) {
      return [await getTrack(query.split('spotify:track:')[1])];
    } else if (query.contains('/track/')) {
      return [await getTrack(query.split('/track/')[1].split('?')[0])];
    } else {
      var response = await get('/search?q=$query&market=$market&type=track');
      final Map json = jsonDecode(response.body);

      if (json['tracks'] == null || json['tracks']['items'] == null) {
        return [];
      }

      List items = json['tracks']['items'];
      List<Track> tracks = [];
      items.forEach((item) {
        tracks.add(_mountTrack(item));
      });

      return tracks;
    }

  }

  Future<Track> getTrack(String id) async {
    var response = await get('/tracks/$id');
    final Map json = jsonDecode(response.body);
    return _mountTrack(json);
  }

  Track _mountTrack(dynamic item) {
    return Track(
      name: item['name'],
      explicit: item['explicit'],
      duration: Duration(milliseconds: item['duration_ms']),
      artists: (item['artists'] as List).map((artist) {
        return Artist(
          name: artist['name']
          );
      }).toList(),
      album: Album(
        name: item['album']['name'],
        releaseDate: Utils.parseStringDate(item['album']['release_date']),
        releaseDatePrecision: item['album']['release_date_precision'],
        images: (item['album']['images'] as List).map((image) {
          return Cover(url: image['url'], height: image['height'], width: image['width']);
        }).toList(),
        artists: (item['album']['artists'] as List).map((artist) {
        return Artist(
          name: artist['name']
          );
      }).toList(),
      ),
      spotify: Spotify(
        id: item['id'],
        uri: Uri.parse(item['href']),
        markets: List.from(Utils.sortByAlphabeticOrder(List.from(item['available_markets'] ?? []))),
      ),
    );
  }
}
