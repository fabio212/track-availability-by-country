import 'package:flutter/material.dart';
import 'package:track_availability_by_country/services/spotify/requests/search_spotify_track.dart';
import 'package:track_availability_by_country/widgets/list_track_card.dart';

import '../../models/track.dart';
import '../../services/spotify/requests/retrieve_all_countries.dart';
import '../../utils/countries.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<Track> _tracks = List.empty();
  final SearchSpotifyTrack _search = SearchSpotifyTrack();
  final RetrieveAllCountries retrieveAllCountries = RetrieveAllCountries();
  String _query = '';
  List<String> _markets = [];
  String _selectedMarket = 'GB';

  @override
  void initState() {
    super.initState();
    _setUpCountries();
  }

  void _setUpCountries() async {
    var markets = await retrieveAllCountries.execute();
    var selectedMarket = await Countries.getLastCountrySelected();
    setState(() {
      _markets = markets;
      _selectedMarket = selectedMarket;
    });
  }

  void _searchTracks(String value) async {
    _query = value;
    var tracks = await _search.searchTracks(_query, market: _selectedMarket);
    setState(() {
      _tracks = tracks;
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
          Row(
            children: [
              Expanded(
                flex: 3,
                child: DropdownMenu(
                  dropdownMenuEntries: _markets.map((market) {
                    return DropdownMenuEntry(value: market, label: market);
                  }).toList(),
                  initialSelection: _selectedMarket,
                  onSelected: (value) {
                    _selectedMarket = value ?? '';
                    Countries.saveLastCountrySelected(_selectedMarket);
                    _searchTracks(_query);
                  },
                ),
              ),
              Expanded(
                flex: 7,
                child: SearchBar(
                  onChanged: (value) => _searchTracks(value),
                ),
              ),
            ],
          ),
          ListTrackCard(
            tracks: _tracks,
            onClick: (String id) {
              Navigator.pushNamed(context, '/track/$id');
            },
          ),
        ],
      )
    );
  }
}
