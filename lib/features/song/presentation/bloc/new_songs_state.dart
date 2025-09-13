import 'package:spotify/features/song/domain/entities/song_entity.dart';

abstract class NewSongsState {}

class NewSongsLoading extends NewSongsState {}

class NewSongsLoaded extends NewSongsState {
  final List<SongEntity> songs;
  NewSongsLoaded({required this.songs});
}

class NewsSongsLoadFailure extends NewSongsState {}
