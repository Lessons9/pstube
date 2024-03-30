import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pstube/data/models/models.dart';
import 'package:pstube/states/states.dart';

class PlaylistPopup extends ConsumerWidget {
  const PlaylistPopup({
    required this.videoData,
    super.key,
  });

  final VideoData videoData;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final playlist = ref.watch(playlistProvider).playlist;
    final playlistP = ref.read(playlistProvider.notifier);
    return Column(
      children: [
        for (final entry in playlist.entries)
          CheckboxListTile(
            value: entry.value.contains(videoData.id.url),
            onChanged: (isTrue) {
              if (isTrue!) {
                playlistP.addVideo(entry.key, videoData.id.url);
                return;
              }

              playlistP.removeVideo(entry.key, videoData.id.url);
            },
            title: Text(entry.key),
          ),
        const SizedBox(height: 8),
      ],
    );
  }
}
