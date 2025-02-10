import 'dart:convert';

import '../../../utils/utils.dart';
import '../../local_storage.dart';
import 'base_spotify.dart';

class RetrieveAllCountries extends BaseSpotify {
  final String _trackId = '1St21ut6MLUzjMC8mlo4aK';

  Future<List<String>> execute() async {
    LocalStorage localStorage = LocalStorage();
    String countries = await localStorage.read('SPOTIFY_COUNTRIES');
    if (countries.isEmpty) {
      try {
        List<String> countriesList = await _retrieveFromTrack();
        localStorage.add('SPOTIFY_COUNTRIES', countriesList.toString());
        return countriesList;
      } catch (e) {
        return [];
      }
    }

    return countries.split('[')[1].split(']')[0].split(', ');
  }

  Future<List<String>> _retrieveFromTrack() async {
    var response = await get('/tracks/$_trackId');
    final Map mapJson = jsonDecode(response.body);
    return Utils.sortByAlphabeticOrder(List.from(mapJson['available_markets'] ?? []));
  }
}
