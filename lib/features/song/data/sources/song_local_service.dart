import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spotify/features/song/data/models/song_model.dart';

abstract class SongLocalService {
  Future<List<SongModel>?> getNewSongs();
  Future<void> setNewSongs(List<SongModel> songs);
  Future<List<SongModel>?> getPlayList();
  Future<void> setPlayList(List<SongModel> playList);
  Future<void> clearSongs();
}

class SongLocalServiceImpl extends SongLocalService {
  final SharedPreferences prefs;
  static const String newSongsCacheKey = "CACHED_NEW_SONGS";
  static const String newSongsCacheTimeKey = "CACHED_NEW_SONGS_TIME";
  static const String playListCacheKey = "CACHED_PLAYLIST";
  static const String playListCacheTimeKey = "CACHED_PLAYLIST_TIME";

  SongLocalServiceImpl({required this.prefs});

  @override
  Future<List<SongModel>?> getNewSongs() async {
    final int timeoutSeconds = dotenv.getInt(
      'NEW_SONGS_CACHE_TIMEOUT_SECONDS',
      fallback: 300,
    );
    return getCacheSongModelListByCacheKey(
      newSongsCacheKey,
      newSongsCacheTimeKey,
      timeoutSeconds,
    );
  }

  @override
  Future<List<SongModel>?> getPlayList() async {
    final int timeoutSeconds = dotenv.getInt(
      'PLAYLIST_CACHE_TIMEOUT_SECONDS',
      fallback: 300,
    );
    return getCacheSongModelListByCacheKey(
      playListCacheKey,
      playListCacheTimeKey,
      timeoutSeconds,
    );
  }

  List<SongModel>? getCacheSongModelListByCacheKey(
    String cacheKey,
    String cacheTimeKey,
    int timeoutSeconds,
  ) {
    final jsonString = prefs.getString(cacheKey);
    final cacheTime = prefs.getInt(cacheTimeKey);

    if (jsonString != null && cacheTime != null) {
      final currentTime = DateTime.now().millisecondsSinceEpoch;
      final cacheDuration = Duration(seconds: timeoutSeconds).inMilliseconds;

      if (currentTime - cacheTime < cacheDuration) {
        final List<dynamic> decoded = json.decode(jsonString);
        return decoded.map((song) {
          return SongModel.fromJson(song);
        }).toList();
      } else {
        return null;
      }
    }
    return null;
  }

  @override
  Future<void> setNewSongs(List<SongModel> songs) async {
    final jsonString = json.encode(songs.map((song) => song.toJson()).toList());
    await prefs.setString(newSongsCacheKey, jsonString);
    await prefs.setInt(
      newSongsCacheTimeKey,
      DateTime.now().millisecondsSinceEpoch,
    );
  }

  @override
  Future<void> setPlayList(List<SongModel> playList) async {
    final jsonString = json.encode(
      playList.map((song) => song.toJson()).toList(),
    );
    await prefs.setString(playListCacheKey, jsonString);
    await prefs.setInt(
      playListCacheTimeKey,
      DateTime.now().millisecondsSinceEpoch,
    );
  }

  @override
  Future<void> clearSongs() async {
    await prefs.remove(newSongsCacheKey);
    await prefs.remove(newSongsCacheTimeKey);
    await prefs.remove(playListCacheKey);
    await prefs.remove(playListCacheTimeKey);
  }
}
