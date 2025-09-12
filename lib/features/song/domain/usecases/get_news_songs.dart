import 'package:spotify/core/usecase/usecase.dart';
import 'package:spotify/features/song/domain/entities/song_entity.dart';
import 'package:spotify/features/song/domain/repositories/song_repository.dart';
import 'package:spotify/service_locator.dart';

class GetNewsSongsUsecase implements UsecaseStream<List<SongEntity>, void> {
  final SongRepository _repository = sl<SongRepository>();

  @override
  Stream<List<SongEntity>> call({void params}) {
    return _repository.getNewSongsStream;
  }
}
