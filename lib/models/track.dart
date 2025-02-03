import 'package:track_availability_by_country/models/spotify.dart';

import 'album.dart';
import 'artist.dart';

class Track {
  String name;
  List<Artist> artists;
  Album album;
  bool explicit;
  Duration duration;
  Spotify spotify;

  Track({required this.name,
         required this.artists,
         required this.album,
         required this.spotify,
         this.explicit = false,
         this.duration = Duration.zero
  });
}
