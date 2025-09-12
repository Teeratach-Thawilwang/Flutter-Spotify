import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify/features/song/domain/usecases/add_or_remove_favorite_song.dart';
import 'package:spotify/features/song/presentation/bloc/favorite_song_state.dart';
import 'package:spotify/service_locator.dart';

class FavoriteSongCubit extends Cubit<FavoriteSongState> {
  FavoriteSongCubit() : super(FavoriteSongInitial());

  Future<void> onToggleFavorite(String songId) async {
    var returnedSongs = await sl<AddOrRemoveFavoriteSongUsecase>().call(
      params: songId,
    );
    returnedSongs.fold((l) {}, (isFavorite) {
      emit(FavoriteSongUpdated(isFavorite: isFavorite));
    });
  }
}
