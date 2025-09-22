import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:spotify/features/song/domain/entities/song_entity.dart';

class SongModel {
  String? id;
  String? title;
  String? artist;
  num? duration;
  Timestamp? releaseDate;
  bool? isFavorite;

  SongModel({
    required this.id,
    required this.title,
    required this.artist,
    required this.duration,
    required this.releaseDate,
    required this.isFavorite,
  });

  factory SongModel.fromEntity(SongEntity entity) {
    return SongModel(
      id: entity.id,
      title: entity.title,
      artist: entity.artist,
      duration: entity.duration,
      releaseDate: entity.releaseDate,
      isFavorite: entity.isFavorite,
    );
  }

  SongEntity toEntity() {
    return SongEntity(
      id: id!,
      title: title!,
      artist: artist!,
      duration: duration!,
      releaseDate: releaseDate!,
      isFavorite: isFavorite!,
    );
  }

  SongModel.fromJson(Map<String, dynamic> data) {
    id = data['id'];
    title = data['title'];
    artist = data['artist'];
    duration = data['duration'];
    releaseDate = transformToTimestampOrNull(data['releaseDate']);
    isFavorite = data['isFavorite'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'artist': artist,
      'duration': duration,
      'releaseDate': releaseDate?.millisecondsSinceEpoch,
      'isFavorite': isFavorite,
    };
  }

  Timestamp? transformToTimestampOrNull(dynamic time) {
    if (time is Timestamp) {
      return time;
    }
    if (time is int) {
      releaseDate = Timestamp.fromMillisecondsSinceEpoch(time);
    }
    if (time is String) {
      releaseDate = Timestamp.fromDate(DateTime.parse(time));
    }
    return null;
  }
}
