import 'package:dartz/dartz.dart';
import 'package:spotify/core/usecase/usecase.dart';
import 'package:spotify/features/song/domain/repositories/song_repository.dart';
import 'package:spotify/service_locator.dart';

class GetNewsSongsUsecase implements Usecase<Either, dynamic> {
  @override
  Future<Either> call({params}) async {
    return await sl<SongRepository>().getNewsSongs();
  }
}
