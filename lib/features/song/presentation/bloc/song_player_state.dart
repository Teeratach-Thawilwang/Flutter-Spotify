abstract class SongPlayerState {}

class SongPlayerLoading extends SongPlayerState {}

class SongPlayerLoaded extends SongPlayerState {}

class SongPlayerFailure extends SongPlayerState {
  final String errorMessage;
  SongPlayerFailure({required this.errorMessage});
}
