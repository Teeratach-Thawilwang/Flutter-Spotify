import 'package:spotify/features/song/domain/entities/song_entity.dart';

abstract class FavoriteSongListState {}

class FavoriteSongListLoading extends FavoriteSongListState {}

class FavoriteSongListLoaded extends FavoriteSongListState {
  final List<SongEntity> favoriteSongs;
  FavoriteSongListLoaded({required this.favoriteSongs});
}

class FavoriteSongListFailure extends FavoriteSongListState {
  final String errorMessage;
  FavoriteSongListFailure({required this.errorMessage});
}
