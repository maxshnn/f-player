import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:f_player/domain/usecases/music_manager_usecases.dart';
import 'package:f_player/core/di/di.dart';
import 'package:f_player/app/pages/home/providers/state/music_state.dart';
import 'package:f_player/app/pages/home/providers/state/music_notifier.dart';

final musicNotifierProvider =
    StateNotifierProvider<MusicNotifier, MusicState>((ref) {
  return MusicNotifier(
    audioPlayer: injection(),
  );
});

final musicListProvider = FutureProvider<List<String>>((ref) async {
  final usecases = MusicManagerUsecases(
    musicManagerRepository: injection(),
  );
  return usecases.getMusic();
});
