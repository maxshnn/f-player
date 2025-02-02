import 'package:f_player/app/pages/home/providers/state/music_state.dart';
import 'package:f_player/data/models/music_model.dart';
import 'package:f_player/domain/usecases/music_manager_usecases.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';

class MusicNotifier extends StateNotifier<MusicState> {
  final AudioPlayer _audioPlayer;
  final MusicManagerUsecases _musicManagerUsecases;

  MusicNotifier({
    required AudioPlayer audioPlayer,
    required MusicManagerUsecases musicManagerUsecases,
  })  : _audioPlayer = audioPlayer,
        _musicManagerUsecases = musicManagerUsecases,
        super(const MusicState());

  Future<void> fetchMusic() async {
    final listOfMusic = await _musicManagerUsecases.getMusic();
    state = state.copyWith(tracks: listOfMusic);
  }

  Future<void> findMusic(String query) async {
    final tracks = await _musicManagerUsecases.findMusic(query);
    if (state.tracks != tracks) {
      state = state.copyWith(tracks: tracks);
    }
  }

  Future<void> playOrPause(MusicModel track) async {
    if (state.isPlaying && state.currentTrack == track) {
      _audioPlayer.pause();
      state = state.copyWith(isPlaying: false);
    } else if (!state.isPlaying && state.currentTrack == track) {
      _audioPlayer.play();
      state = state.copyWith(isPlaying: true);
    } else if (state.currentTrack != track) {
      _audioPlayer
        ..setFilePath(track.path)
        ..play();
      state = state.copyWith(
        isPlaying: true,
        currentTrack: track,
      );
    }
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }
}
