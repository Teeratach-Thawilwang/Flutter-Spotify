import 'package:dartz/dartz.dart';
import 'package:spotify/core/usecase/usecase.dart';
import 'package:spotify/features/song/domain/repositories/song_repository.dart';
import 'package:spotify/service_locator.dart';

class AddOrRemoveFavoriteSongUsecase implements Usecase<Either, String> {
  @override
  Future<Either<String, bool>> call({String? params}) async {
    return await sl<SongRepository>().addOrRemoveFavoriteSong(params!);
  }
}
