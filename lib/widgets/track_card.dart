import 'package:flutter/material.dart';

import '../models/track.dart';

class TrackCard extends StatelessWidget {
  final Track track;
  const TrackCard({Key? key, required this.track}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Row(
              children: [
                Image.network(track.album.images.last.url),
                track.explicit ? Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.red,
                      width: 1,
                    )
                  ),
                  child: const Text('E', style: TextStyle(color: Colors.red)),
                ) : Container(),
                const SizedBox(width: 10),
                Text(track.name),
              ],
            ),
            Row(
              children: [
                Text(track.artists.map((artist) => artist.name).join(', ')),
              ],
            ),
            Row(
              children: [
                Text(track.album.name),
              ],
            ),
            Row(
              children: [
                Text(track.duration.toString()),
              ],
            ),
            const SizedBox(height: 20),
          ],
        )
    );
  }
}
