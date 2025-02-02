import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:f_player/core/di/di.dart';
import 'package:f_player/app/pages/home/providers/state/music_state.dart';
import 'package:f_player/app/pages/home/providers/state/music_notifier.dart';

final musicNotifierProvider =
    StateNotifierProvider<MusicNotifier, MusicState>((ref) {
  return MusicNotifier(
    audioPlayer: injection(),
    musicManagerUsecases: injection(),
  )..fetchMusic();
});
