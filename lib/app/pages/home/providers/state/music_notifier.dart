import 'package:f_player/app/pages/home/providers/state/music_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';

class MusicNotifier extends StateNotifier<MusicState> {
  final AudioPlayer _audioPlayer;

  MusicNotifier({required AudioPlayer audioPlayer})
      : _audioPlayer = audioPlayer,
        super(MusicState());

  Future<void> playOrPause(String trackPath) async {
    if (state.isPlaying && state.currentTrack == trackPath) {
      await _audioPlayer.pause();
      state = state.copyWith(isPlaying: false);
    } else {
      await _audioPlayer.setFilePath(trackPath);
      await _audioPlayer.play();
      state = state.copyWith(
        isPlaying: true,
        currentTrack: trackPath,
      );
    }
  }

  Future<void> stop() async {
    await _audioPlayer.stop();
    state = state.copyWith(isPlaying: false, currentTrack: '');
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }
}
