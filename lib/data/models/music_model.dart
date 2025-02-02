import 'package:freezed_annotation/freezed_annotation.dart';

part 'music_model.freezed.dart';
part 'music_model.g.dart';

@freezed
class MusicModel with _$MusicModel {
  const factory MusicModel({
    required int id,
    required String path,
    required String title,
    String? track,
    required String displayName,
    required int size,
    required String mimeType,
    required int duration,
    required String artist,
    required String album,
  }) = _MusicModel;

  factory MusicModel.fromJson(Map<String, Object?> json) =>
      _$MusicModelFromJson(json);
}
