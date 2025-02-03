import 'package:flutter/material.dart';

import '../models/track.dart';
import '../utils/utils.dart';

class TrackCard extends StatelessWidget {
  final Track track;
  final void Function()? onTap;
  const TrackCard({Key? key, required this.track, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(track.album.images.last.url),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text('🎵 '),
              track.explicit ? Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.red,
                    width: 1,
                  )
                ),
                child: const Text('E', style: TextStyle(color: Colors.red)),
              ) : Container(),
              track.explicit ? const SizedBox(width: 10) : Container(),
              Text(track.name),
            ],
          ),
          const SizedBox(width: 10),
          Text('🎤 ' + track.artists.map((artist) => artist.name).join(', ')),
          Text('💿 ' + track.album.name),
          Text('⏳ ' + Utils.minuteSecondFormat(track.duration)),
        ],
      ),
      onTap: onTap,
    );
  }
}
