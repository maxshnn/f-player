import 'package:flutter/services.dart';

class MusicManagerService {
  Future<List<Map<String, dynamic>>> getMusic() async {
    const platform = MethodChannel('audio_files');
    final musicPaths = await platform.invokeMethod<List>('getAudioFiles') ?? [];
    return musicPaths.asMap().entries.map((entry) {
      return {
        "id": entry.key,
        ...Map<String, dynamic>.from(entry.value),
      };
    }).toList();
  }
}
