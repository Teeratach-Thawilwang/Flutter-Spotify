abstract class FavoriteSongToggleState {}

class FavoriteSongToggleInitial extends FavoriteSongToggleState {}

class FavoriteSongToggleUpdated extends FavoriteSongToggleState {}

class FavoriteSongToggleFailure extends FavoriteSongToggleState {
  final String errorMessage;
  FavoriteSongToggleFailure({required this.errorMessage});
}
