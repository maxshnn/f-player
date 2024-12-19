import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:f_player/app/pages/home/providers/music_provider.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final musicState = ref.watch(musicNotifierProvider);
    final musicList = ref.watch(musicListProvider);

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Музыкальный плеер'),
        ),
        body: musicList.when(
          data: (tracks) => ListView.builder(
            itemCount: tracks.length,
            itemBuilder: (context, index) {
              final trackPath = tracks[index];
              final isPlaying =
                  musicState.isPlaying && musicState.currentTrack == trackPath;

              return ListTile(
                title: Text(trackPath),
                trailing: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
                onTap: () {
                  ref
                      .read(musicNotifierProvider.notifier)
                      .playOrPause(trackPath);
                },
              );
            },
          ),
          loading: () => const Center(
            child: CircularProgressIndicator(),
          ),
          error: (error, _) => Center(
            child: Text('Ошибка: $error'),
          ),
        ),
      ),
    );
  }
}
