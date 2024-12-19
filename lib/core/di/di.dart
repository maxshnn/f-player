import 'package:f_player/data/repositories/music_manager_repository_impl.dart';
import 'package:f_player/data/services/local/music_manager_service.dart';
import 'package:f_player/domain/repositories/music_manager_repository.dart';
import 'package:f_player/domain/usecases/music_manager_usecases.dart';
import 'package:get_it/get_it.dart';
import 'package:just_audio/just_audio.dart';

final injection = GetIt.instance;

void setup() {
  injection
    ..registerLazySingleton<MusicManagerService>(
      () => MusicManagerService(),
    )
    ..registerLazySingleton<MusicManagerRepository>(
      () => MusicManagerRepositoryImpl(
        musicManagerService: injection(),
      ),
    )
    ..registerLazySingleton<MusicManagerUsecases>(
      () => MusicManagerUsecases(
        musicManagerRepository: injection(),
      ),
    )
    ..registerLazySingleton<AudioPlayer>(
      () => AudioPlayer(),
    );
}
