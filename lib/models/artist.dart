import 'cover.dart';

class Artist {
  String name;
  int followers;
  List<Cover> images;

  Artist({required this.name, this.followers = 0, this.images = const []});
}
