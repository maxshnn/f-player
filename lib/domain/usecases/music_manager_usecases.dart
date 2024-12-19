import 'dart:io';

import 'package:f_player/domain/repositories/music_manager_repository.dart';
import 'package:permission_handler/permission_handler.dart';

class MusicManagerUsecases {
  final MusicManagerRepository _musicManagerRepository;

  MusicManagerUsecases({
    required MusicManagerRepository musicManagerRepository,
  }) : _musicManagerRepository = musicManagerRepository;

  Stream<File> getAllMusic() async* {
    yield* _musicManagerRepository.getAllMusic();
  }

  Future<List<String>> getMusic() async {
    final permissionStorageIsGranted = await Permission.storage.isGranted;
    if (!permissionStorageIsGranted) {
      await Permission.storage.request();
    }
    return await _musicManagerRepository.getMusic();
  }
}
