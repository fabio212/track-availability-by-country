import 'package:flutter/material.dart';
import 'package:track_availability_by_country/widgets/track_card.dart';

import '../models/track.dart';
import '../services/spotify/requests/search_spotify_track.dart';

class ListTrackCard extends StatelessWidget {
  final List<Track> tracks;
  final double? height;
  final SearchSpotifyTrack _search = SearchSpotifyTrack();
  Function(String)? onClick;
  ListTrackCard({Key? key, required this.tracks, this.height, this.onClick}) : super(key: key);

  List<Widget> _mountTracksWidgetsList(List<Track> tracks) {
    return tracks.map((track) {
      return TrackCard(track: track);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 400,
      child: ListView.builder(
        itemCount: tracks.length,
        itemBuilder: (context, index) {
          final item = tracks[index];
          return TrackCard(
            track: item,
            onTap: () {
              if (onClick != null) {
                onClick!(item.spotify.id);
              }
            },
          );
        },
      ),
    );
  }
}
