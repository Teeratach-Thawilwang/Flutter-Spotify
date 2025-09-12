abstract class FavoriteSongState {}

class FavoriteSongInitial extends FavoriteSongState {}

class FavoriteSongUpdated extends FavoriteSongState {
  final bool isFavorite;

  FavoriteSongUpdated({required this.isFavorite});
}
