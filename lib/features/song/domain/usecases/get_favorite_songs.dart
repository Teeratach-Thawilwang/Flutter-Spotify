import 'package:dartz/dartz.dart';
import 'package:spotify/core/usecase/usecase.dart';
import 'package:spotify/features/song/domain/entities/song_entity.dart';
import 'package:spotify/features/song/domain/repositories/song_repository.dart';
import 'package:spotify/service_locator.dart';

class GetFavoriteSongsUsecase implements Usecase<Either, dynamic> {
  @override
  Future<Either<String, List<SongEntity>>> call({params}) async {
    return await sl<SongRepository>().getFavoriteSongs();
  }
}
