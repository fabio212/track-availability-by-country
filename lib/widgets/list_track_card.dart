import 'package:flutter/material.dart';
import 'package:track_availability_by_country/widgets/track_card.dart';

import '../models/track.dart';

class ListTrackCard extends StatelessWidget {
  final List<Track> tracks;
  final double? height;
  final Function(String)? onClick;
  ListTrackCard({Key? key, required this.tracks, this.height, this.onClick}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: tracks.length,
        itemBuilder: (_, index) {
          final item = tracks[index];
          return ListTile(
            title: TrackCard(track: item),
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
