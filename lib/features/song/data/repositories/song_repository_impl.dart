import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:rxdart/rxdart.dart';
import 'package:spotify/features/song/data/sources/song_firebase_service.dart';
import 'package:spotify/features/song/domain/entities/song_entity.dart';
import 'package:spotify/features/song/domain/repositories/song_repository.dart';
import 'package:spotify/service_locator.dart';

class SongRepositoryImpl extends SongRepository {
  final _newSongsController = BehaviorSubject<List<SongEntity>>();
  final _playListController = BehaviorSubject<List<SongEntity>>();
  List<SongEntity> _newSongs = [];
  List<SongEntity> _playList = [];

  @override
  Stream<List<SongEntity>> get getNewSongsStream {
    if (_newSongs.isEmpty) {
      getNewSongs();
    }
    return _newSongsController.stream;
  }

  @override
  Stream<List<SongEntity>> get getPlayListStream {
    if (_playList.isEmpty) {
      getPlayList();
    }
    return _playListController.stream;
  }

  Future<void> getNewSongs() async {
    final either = await sl<SongFirebaseService>().getNewSongs();
    either.fold(
      (error) {
        _newSongsController.addError(error);
      },
      (data) {
        _newSongs = data;
        _newSongsController.add(List.unmodifiable(_newSongs));
      },
    );
  }

  Future<void> getPlayList() async {
    final either = await sl<SongFirebaseService>().getPlayList();
    either.fold(
      (error) {
        _playListController.addError(error);
      },
      (data) {
        _playList = data;
        _playListController.add(List.unmodifiable(_playList));
      },
    );
  }

  @override
  Future<Either<String, bool>> addOrRemoveFavoriteSong(String songId) async {
    final either = await sl<SongFirebaseService>().addOrRemoveFavoriteSong(
      songId,
    );

    either.fold((l) => {}, (isFavorite) {
      _newSongs = _newSongs.map((song) {
        if (song.id == songId) {
          return song.copyWith(isFavorite: isFavorite);
        }
        return song;
      }).toList();
      _newSongsController.add(List.unmodifiable(_newSongs));

      _playList = _playList.map((song) {
        if (song.id == songId) {
          return song.copyWith(isFavorite: isFavorite);
        }
        return song;
      }).toList();
      _playListController.add(List.unmodifiable(_playList));
    });

    return either;
  }
}
