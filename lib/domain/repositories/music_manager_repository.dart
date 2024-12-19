import 'dart:io';

abstract class MusicManagerRepository {
  Stream<File> getAllMusic();

  Future<List<String>> getMusic();
}
