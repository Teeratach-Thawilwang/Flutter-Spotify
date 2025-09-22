import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:rxdart/rxdart.dart';
import 'package:spotify/features/song/data/models/song_model.dart';
import 'package:spotify/features/song/data/sources/song_local_service.dart';
import 'package:spotify/features/song/data/sources/song_remote_service.dart';
import 'package:spotify/features/song/domain/entities/song_entity.dart';
import 'package:spotify/features/song/domain/repositories/song_repository.dart';
import 'package:spotify/service_locator.dart';
import 'package:synchronized/synchronized.dart';

class SongRepositoryImpl extends SongRepository {
  final _lock = Lock();
  final _newSongsController = BehaviorSubject<List<SongEntity>>();
  final _playListController = BehaviorSubject<List<SongEntity>>();
  List<SongEntity> _newSongs = [];
  List<SongEntity> _playList = [];

  final SongRemoteService remoteService;
  final SongLocalService localService;

  SongRepositoryImpl({required this.remoteService, required this.localService});

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
    final cacheNewSongs = await localService.getNewSongs();
    if (cacheNewSongs != null) {
      _newSongs = cacheNewSongs.map((song) => song.toEntity()).toList();
      _newSongsController.add(List.unmodifiable(_newSongs));
      return;
    }

    final either = await sl<SongRemoteService>().getNewSongs();
    either.fold(
      (error) {
        _newSongsController.addError(error);
      },
      (songModels) async {
        await localService.setNewSongs(songModels);
        _newSongs = songModels
            .map((songModel) => songModel.toEntity())
            .toList();
        _newSongsController.add(List.unmodifiable(_newSongs));
      },
    );
  }

  Future<void> getPlayList() async {
    final cachePlayList = await localService.getNewSongs();
    if (cachePlayList != null) {
      _playList = cachePlayList.map((song) => song.toEntity()).toList();
      _playListController.add(List.unmodifiable(_playList));
      return;
    }

    final either = await sl<SongRemoteService>().getPlayList();
    either.fold(
      (error) {
        _playListController.addError(error);
      },
      (songModels) async {
        await localService.setNewSongs(songModels);
        _playList = songModels
            .map((songModel) => songModel.toEntity())
            .toList();
        _playListController.add(List.unmodifiable(_playList));
      },
    );
  }

  @override
  Future<Either<String, bool>> addOrRemoveFavoriteSong(String songId) async {
    return await _lock.synchronized(() async {
      final either = await sl<SongRemoteService>().addOrRemoveFavoriteSong(
        songId,
      );

      either.fold((l) => {}, (isFavorite) async {
        _newSongs = transformSongListById(_newSongs, songId, isFavorite);
        _newSongsController.add(List.unmodifiable(_newSongs));

        _playList = transformSongListById(_playList, songId, isFavorite);
        _playListController.add(List.unmodifiable(_playList));

        await setCacheSongOnFavoriteChange();
      });

      return either;
    });
  }

  @override
  Future<Either<String, List<SongEntity>>> getFavoriteSongs() async {
    final result = await sl<SongRemoteService>().getFavoriteSongs();
    return result.fold((l) => left(l), (songModels) {
      return Right(
        songModels.map((songModel) => songModel.toEntity()).toList(),
      );
    });
  }

  @override
  Future<void> clearSongs() async {
    _newSongs = [];
    _newSongsController.add(List.unmodifiable(_newSongs));
    _playList = [];
    _playListController.add(List.unmodifiable(_playList));
    await localService.clearSongs();
  }

  Future<void> setCacheSongOnFavoriteChange() async {
    await localService.setNewSongs(
      _newSongs.map((songEntity) => SongModel.fromEntity(songEntity)).toList(),
    );
    await localService.setNewSongs(
      _playList.map((songEntity) => SongModel.fromEntity(songEntity)).toList(),
    );
  }

  List<SongEntity> transformSongListById(
    List<SongEntity> list,
    String songId,
    bool isFavorite,
  ) {
    return list.map((song) {
      if (song.id == songId) {
        return song.copyWith(isFavorite: isFavorite);
      }
      return song;
    }).toList();
  }
}
