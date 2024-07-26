import 'artist.dart';
import 'cover.dart';

class Album {
  String name;
  List<Cover> images;
  DateTime releaseDate;
  String releaseDatePrecision;
  List<Artist> artists;

  Album({ required this.name, this.images = const [], required this.releaseDate, this.releaseDatePrecision = 'day', required this.artists });
}
