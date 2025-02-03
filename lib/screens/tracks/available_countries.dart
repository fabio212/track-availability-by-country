import 'package:flutter/material.dart';
import 'package:track_availability_by_country/services/spotify/requests/search_spotify_track.dart';
import 'package:track_availability_by_country/widgets/track_card.dart';

import '../../models/track.dart';

class AvailableCountries extends StatefulWidget {
  const AvailableCountries({super.key, required this.trackId});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String trackId;

  @override
  State<AvailableCountries> createState() => _AvailableCountriesState();
}

class _AvailableCountriesState extends State<AvailableCountries> {
  late Track _track;
  final SearchSpotifyTrack _search = SearchSpotifyTrack();

  @override
  void initState() {
    super.initState();
    getTrack(widget.trackId);
  }

  void getTrack(String value) async {
    var track = await _search.getTrack(value);
    setState(() {
      _track = track;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      body: Column(
        children: <Widget>[
          const Text('Faixa Selecionada'),
          _track == null ? Container() : TrackCard(track: _track),
          const SizedBox(height: 20),
          const Text('Esta faixa está disponível nos seguintes países'),
          const SizedBox(height: 20),
          Container(
            child: Text(_track.spotify.markets.join(', ')),
          ),
        ],
      )
    );
  }
}
