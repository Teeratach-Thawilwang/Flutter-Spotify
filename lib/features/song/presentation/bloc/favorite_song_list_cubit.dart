import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify/features/song/domain/entities/song_entity.dart';
import 'package:spotify/features/song/domain/usecases/get_favorite_songs.dart';
import 'package:spotify/features/song/presentation/bloc/favorite_song_list_state.dart';
import 'package:spotify/service_locator.dart';

class FavoriteSongListCubit extends Cubit<FavoriteSongListState> {
  FavoriteSongListCubit() : super(FavoriteSongListLoading());

  List<SongEntity> favoriteSongs = [];

  Future<void> getFavoriteSongs() async {
    var result = await sl<GetFavoriteSongsUsecase>().call();

    result.fold((error) => emit(FavoriteSongListFailure(errorMessage: error)), (
      songs,
    ) {
      favoriteSongs = songs;
      emit(FavoriteSongListLoaded(favoriteSongs: favoriteSongs));
    });
  }

  void removeSongByIndex(int index) {
    favoriteSongs.removeAt(index);
    emit(FavoriteSongListLoaded(favoriteSongs: favoriteSongs));
  }
}
