import 'package:f_player/data/models/music_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'music_state.freezed.dart';

@freezed
class MusicState with _$MusicState {
  const MusicState._();
  const factory MusicState({
    @Default(false) bool isPlaying,
    MusicModel? currentTrack,
    @Default([]) List<MusicModel> tracks,
  }) = _MusicState;
}
