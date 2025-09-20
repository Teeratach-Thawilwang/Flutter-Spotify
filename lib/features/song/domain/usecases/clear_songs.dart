import 'package:spotify/core/usecase/usecase.dart';
import 'package:spotify/features/song/domain/repositories/song_repository.dart';
import 'package:spotify/service_locator.dart';

class ClearSongsUsecase implements Usecase<void, dynamic> {
  @override
  Future<void> call({params}) async {
    await sl<SongRepository>().clearSongs();
  }
}
