import 'dart:async';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:track_availability_by_country/services/spotify/requests/search_spotify_track.dart';
import 'package:track_availability_by_country/widgets/list_track_card.dart';

import '../../models/track.dart';
import '../../services/spotify/requests/retrieve_all_countries.dart';
import '../../utils/countries.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key, required this.title});

  final String title;

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final SearchSpotifyTrack _search = SearchSpotifyTrack();
  final RetrieveAllCountries retrieveAllCountries = RetrieveAllCountries();
  String _query = '';
  List<String> _markets = [];
  String _selectedMarket = '';
  Timer? _inputTimer;

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

  Future<List<Track>> _searchTracks(String value) async {
    return _search.searchTracks(value, market: _selectedMarket);
  }

  DropdownButton _mountDropdown(BuildContext context) {
    return DropdownButton(
      items: _markets.map((market) {
        String countryName = Countries.getCountryName(market);
        return DropdownMenuItem(value: market, child: Text(countryName.isEmpty ? market : '$market - $countryName'));
      }).toList(),
      onChanged: (value) async {
        _selectedMarket = value ?? '';
        await Countries.saveLastCountrySelected(_selectedMarket);
        _setUpCountries();
        if (_query.isNotEmpty) _searchTracks(_query);
      },
      hint: Text(AppLocalizations.of(context)!.select),
      value: _selectedMarket,
    );
  }

  TextField _mountInputSearch(BuildContext context) {
    return TextField(
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        hintText: 'Search',
      ),
      onChanged: _onTextChanged,
    );
  }

  void _onTextChanged(String text) {
    if (_inputTimer != null) {
      _inputTimer!.cancel();
    }

    _inputTimer = Timer(const Duration(seconds: 1), () {
      setState(() {
        _query = text;
      });
    });
  }

  @override
  void dispose() {
    _inputTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(AppLocalizations.of(context)!.appDescription),
              const SizedBox(height: 16),
              LayoutBuilder(
                builder: (context, constraints) {
                  if (constraints.maxWidth < 600) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _mountDropdown(context),
                        const SizedBox(height: 8),
                        _mountInputSearch(context),
                      ],
                    );
                  } else {
                    return Row(
                      children: [
                        Expanded(
                          child: _mountDropdown(context),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: _mountInputSearch(context),
                        ),
                      ],
                    );
                  }
                },
              ),
              const SizedBox(height: 16),
              FutureBuilder<List<Track>>(
                future: _searchTracks(_query),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text(AppLocalizations.of(context)!.errorLoadingData));
                  } else {
                    return ListTrackCard(
                      tracks: snapshot.data!,
                      onClick: (String id) {
                        context.go('/track/$id');
                      },
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
