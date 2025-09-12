import 'package:spotify/core/usecase/usecase.dart';
import 'package:spotify/features/song/domain/entities/song_entity.dart';
import 'package:spotify/features/song/domain/repositories/song_repository.dart';
import 'package:spotify/service_locator.dart';

class GetPlayListUsecase implements UsecaseStream<List<SongEntity>, void> {
  @override
  Stream<List<SongEntity>> call({params}) {
    return sl<SongRepository>().getPlayListStream;
  }
}
