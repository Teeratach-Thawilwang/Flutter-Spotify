import 'package:cloud_firestore/cloud_firestore.dart';

class SongEntity {
  final String id;
  final String title;
  final String artist;
  final num duration;
  final Timestamp releaseDate;
  final bool isFavorite;

  SongEntity({
    required this.id,
    required this.title,
    required this.artist,
    required this.duration,
    required this.releaseDate,
    required this.isFavorite,
  });

  SongEntity copyWith({
    String? id,
    String? title,
    String? artist,
    num? duration,
    Timestamp? releaseDate,
    bool? isFavorite,
  }) {
    return SongEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      artist: artist ?? this.artist,
      duration: duration ?? this.duration,
      releaseDate: releaseDate ?? this.releaseDate,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}
