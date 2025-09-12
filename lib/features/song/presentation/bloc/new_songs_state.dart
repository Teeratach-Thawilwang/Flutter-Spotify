import 'package:spotify/features/song/domain/entities/song_entity.dart';

abstract class NewsSongsState {}

class NewSongsLoading extends NewsSongsState {}

class NewSongsLoaded extends NewsSongsState {
  final List<SongEntity> songs;
  NewSongsLoaded({required this.songs});
}

class NewsSongsLoadFailure extends NewsSongsState {}
