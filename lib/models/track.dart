import 'album.dart';
import 'artist.dart';

class Track {
  String name;
  List<Artist> artists;
  Album album;
  List<String> markets;
  bool explicit;
  Duration duration;

  Track({required this.name, required this.artists, required this.album, this.markets = const [], this.explicit = false, this.duration = Duration.zero});
}
