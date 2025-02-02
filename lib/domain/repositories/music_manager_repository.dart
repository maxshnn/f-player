import 'package:f_player/data/models/music_model.dart';

abstract class MusicManagerRepository {
  Future<List<MusicModel>> getMusic();
}
