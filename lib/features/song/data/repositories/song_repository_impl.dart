import 'package:dartz/dartz.dart';
import 'package:spotify/features/song/data/sources/song_firebase_service.dart';
import 'package:spotify/features/song/domain/repositories/song_repository.dart';
import 'package:spotify/service_locator.dart';

class SongRepositoryImpl extends SongRepository {
  @override
  Future<Either> getNewsSongs() async {
    return await sl<SongFirebaseService>().getNewsSongs();
  }

  @override
  Future<Either> getPlayList() async {
    return await sl<SongFirebaseService>().getPlayList();
  }
}
