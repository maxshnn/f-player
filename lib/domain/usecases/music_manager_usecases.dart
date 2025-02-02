import 'package:f_player/data/models/music_model.dart';
import 'package:f_player/domain/repositories/music_manager_repository.dart';
import 'package:permission_handler/permission_handler.dart';

class MusicManagerUsecases {
  final MusicManagerRepository _musicManagerRepository;
  List<MusicModel> _listOfMusic = [];

  MusicManagerUsecases({
    required MusicManagerRepository musicManagerRepository,
  }) : _musicManagerRepository = musicManagerRepository;

  Future<List<MusicModel>> getMusic() async {
    final permissionStorageIsGranted = await Permission.storage.isGranted;
    if (!permissionStorageIsGranted) {
      await Permission.storage.request();
    }
    _listOfMusic = await _musicManagerRepository.getMusic();
    return _listOfMusic;
  }

  Future<List<MusicModel>> findMusic(String query) async {
    if (query.length < 2) {
      return _listOfMusic;
    }
    final data = _listOfMusic.where((music) {
      final lowerQuery = query.toLowerCase();
      return music.title.toLowerCase().contains(lowerQuery) ||
          music.artist.toLowerCase().contains(lowerQuery) ||
          music.album.toLowerCase().contains(lowerQuery);
    }).toList();
    return data;
  }
}
