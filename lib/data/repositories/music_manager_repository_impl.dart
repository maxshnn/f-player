import 'package:f_player/data/models/music_model.dart';
import 'package:f_player/data/services/local/music_manager_service.dart';
import 'package:f_player/domain/repositories/music_manager_repository.dart';

class MusicManagerRepositoryImpl implements MusicManagerRepository {
  final MusicManagerService _musicManagerService;

  MusicManagerRepositoryImpl({
    required MusicManagerService musicManagerService,
  }) : _musicManagerService = musicManagerService;

  @override
  Future<List<MusicModel>> getMusic() async {
    final data = await _musicManagerService.getMusic();
    return List.generate(
      data.length,
      (index) => MusicModel.fromJson(
        data[index],
      ),
    );
  }
}
