import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:f_player/app/pages/home/providers/music_provider.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final musicState = ref.watch(musicNotifierProvider);

    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: TextField(
              onTapOutside: (event) => FocusScope.of(context).unfocus(),
              onChanged: (value) =>
                  ref.read(musicNotifierProvider.notifier).findMusic(value),
            ),
          ),
          body: Builder(
            builder: (context) {
              if (musicState.tracks.isEmpty) {
                return Center(
                  child: ElevatedButton(
                    onPressed: () =>
                        ref.read(musicNotifierProvider.notifier).fetchMusic(),
                    child: const Text('Повторить'),
                  ),
                );
              }
              return ListView.builder(
                itemCount: musicState.tracks.length,
                itemBuilder: (context, index) {
                  final track = musicState.tracks[index];
                  final showTrailing = musicState.currentTrack?.id ==
                      musicState.tracks[index].id;

                  return ListTile(
                    title: Text(track.title),
                    leading: Text(track.artist),
                    trailing: showTrailing
                        ? Icon(
                            musicState.isPlaying
                                ? Icons.pause
                                : Icons.play_arrow,
                          )
                        : const SizedBox(),
                    onTap: () => ref
                        .read(musicNotifierProvider.notifier)
                        .playOrPause(track),
                  );
                },
              );
            },
          )),
    );
  }
}
