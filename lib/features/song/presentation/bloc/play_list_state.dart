import 'package:spotify/features/song/domain/entities/song_entity.dart';

abstract class PlayListState {}

class PlayListLoading extends PlayListState {}

class PlayListLoaded extends PlayListState {
  final List<SongEntity> songs;
  PlayListLoaded({required this.songs});
}

class PlayListLoadFailure extends PlayListState {
  final String errorMessage;
  PlayListLoadFailure({required this.errorMessage});
}
