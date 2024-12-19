import 'dart:io';

import 'package:flutter/services.dart';

class MusicManagerService {
  @Deprecated('Use getMusic()')
  Stream<File> stream() async* {
    final directory = Directory('/storage/emulated/0');

    if (!await directory.exists()) {
      return;
    }
    final directories = directory.list(recursive: true, followLinks: false);
    await for (final entity in directories) {
      if (entity is File) {
        final ext = entity.path.split('.').last.toLowerCase();
        if (['mp3', 'wav', 'flac', 'aac', 'ogg'].contains(ext)) {
          yield entity;
        }
      }
    }
  }

  Future<List<String>> getMusic() async {
    const platform = MethodChannel('audio_files');
    final musicPaths =
        await platform.invokeMethod<List<dynamic>>('getAudioFiles') ?? [];
    final result = musicPaths
        .cast<String>()
        .map(
          (path) => path.toString(),
        )
        .toList();
    return result;
  }
}
