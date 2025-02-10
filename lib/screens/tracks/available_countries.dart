import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:track_availability_by_country/services/spotify/requests/search_spotify_track.dart';
import 'package:track_availability_by_country/widgets/track_card.dart';

import '../../models/track.dart';
import '../../utils/countries.dart';

class AvailableCountries extends StatefulWidget {
  const AvailableCountries({super.key, required this.trackId});

  final String trackId;

  @override
  State<AvailableCountries> createState() => _AvailableCountriesState();
}

class _AvailableCountriesState extends State<AvailableCountries> {
  final SearchSpotifyTrack _search = SearchSpotifyTrack();
  String _userCountry = '';

  @override
  void initState() {
    super.initState();
    _setUserCountry();
  }

  Future<void> _setUserCountry() async {
    _userCountry = await Countries.getUserCountry();
    setState(() {
      _userCountry = _userCountry;
    });
  }

  Future<Track> _getTrack(String value) async {
    return _search.getTrack(value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Track>(
        future: _getTrack(widget.trackId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text(AppLocalizations.of(context)!.errorLoadingData));
          } else {
            final track = snapshot.data!;
            return Column(
              children: <Widget>[
                Text(AppLocalizations.of(context)!.selectedTrack),
                TrackCard(track: track),
                const SizedBox(height: 20),
                Text(AppLocalizations.of(context)!.countriesList(track.spotify.markets.length)),
                Text(AppLocalizations.of(context)!.includingCountry(Countries.getCountryName(_userCountry))),
                const SizedBox(height: 20),
                Expanded(
                  child: ListView.builder(
                    itemCount: track.spotify.markets.length,
                    itemBuilder: (_, index) {
                      final item = track.spotify.markets[index];
                      String countryName = Countries.getCountryName(item);
                      return ListTile(
                        title: Text(
                          countryName.isEmpty ? item : '$item - $countryName',
                          style: item == _userCountry ? const TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ) : null,
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          }
        },
      )
    );
  }
}
