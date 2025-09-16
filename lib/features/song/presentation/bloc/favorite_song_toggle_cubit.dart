import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify/features/song/domain/usecases/add_or_remove_favorite_song.dart';
import 'package:spotify/features/song/presentation/bloc/favorite_song_toggle_state.dart';
import 'package:spotify/service_locator.dart';

class FavoriteSongToggleCubit extends Cubit<FavoriteSongToggleState> {
  FavoriteSongToggleCubit() : super(FavoriteSongToggleInitial());

  Future<void> onToggleFavorite(String songId) async {
    var isFavorite = await sl<AddOrRemoveFavoriteSongUsecase>().call(
      params: songId,
    );
    isFavorite.fold(
      (error) {
        emit(FavoriteSongToggleFailure(errorMessage: error));
      },
      (isFavorite) {
        emit(FavoriteSongToggleUpdated());
      },
    );
  }
}
