import 'package:dartz/dartz.dart';
import 'package:spotify/features/song/domain/entities/song_entity.dart';

abstract class SongRepository {
  Stream<List<SongEntity>> get getNewSongsStream;
  Stream<List<SongEntity>> get getPlayListStream;
  Future<Either<String, bool>> addOrRemoveFavoriteSong(String songId);
  Future<Either<String, List<SongEntity>>> getFavoriteSongs();
}
