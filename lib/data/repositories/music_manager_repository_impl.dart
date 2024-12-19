import 'dart:io';

import 'package:f_player/data/services/local/music_manager_service.dart';
import 'package:f_player/domain/repositories/music_manager_repository.dart';

class MusicManagerRepositoryImpl implements MusicManagerRepository {
  final MusicManagerService _musicManagerService;

  MusicManagerRepositoryImpl({
    required MusicManagerService musicManagerService,
  }) : _musicManagerService = musicManagerService;

  @override
  Stream<File> getAllMusic() async* {
    yield* _musicManagerService.stream();
  }

  @override
  Future<List<String>> getMusic() async {
    return _musicManagerService.getMusic();
  }
}
