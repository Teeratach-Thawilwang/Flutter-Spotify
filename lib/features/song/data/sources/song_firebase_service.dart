import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:spotify/features/song/data/models/song_model.dart';
import 'package:spotify/features/song/domain/entities/song_entity.dart';

abstract class SongFirebaseService {
  Future<Either<String, List<SongEntity>>> getNewSongs();
  Future<Either<String, List<SongEntity>>> getPlayList();
  Future<Either<String, bool>> addOrRemoveFavoriteSong(String songId);
  Future<bool> isFavoriteSong(String songId);
  Future<Either<String, List<SongEntity>>> getFavoriteSongs();
}

class SongFirebaseServiceImpl extends SongFirebaseService {
  @override
  Future<Either<String, List<SongEntity>>> getNewSongs() async {
    try {
      List<SongEntity> songs = [];
      var data = await FirebaseFirestore.instance
          .collection('Songs')
          .orderBy('releaseDate', descending: true)
          .limit(3)
          .get();
      for (var element in data.docs) {
        var songModel = SongModel.fromJson(element.data());
        songModel.id = element.reference.id;

        bool isFavorite = await isFavoriteSong(element.reference.id);
        songModel.isFavorite = isFavorite;

        songs.add(songModel.toEntity());
      }
      return Right(songs);
    } catch (e) {
      return Left('error: $e');
    }
  }

  @override
  Future<Either<String, List<SongEntity>>> getPlayList() async {
    try {
      List<SongEntity> songs = [];
      var data = await FirebaseFirestore.instance
          .collection('Songs')
          .orderBy('releaseDate', descending: true)
          .limit(10)
          .get();
      for (var element in data.docs) {
        var songModel = SongModel.fromJson(element.data());
        songModel.id = element.reference.id;

        bool isFavorite = await isFavoriteSong(element.reference.id);
        songModel.isFavorite = isFavorite;

        songs.add(songModel.toEntity());
      }
      return Right(songs);
    } catch (e) {
      return Left('error: $e');
    }
  }

  @override
  Future<Either<String, bool>> addOrRemoveFavoriteSong(String songId) async {
    try {
      final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
      late bool isFavorite;

      var user = firebaseAuth.currentUser;
      String uid = user!.uid;

      QuerySnapshot favoriteSong = await firebaseFirestore
          .collection('Users')
          .doc(uid)
          .collection('Favorites')
          .where('songId', isEqualTo: songId)
          .get();

      if (favoriteSong.docs.isNotEmpty) {
        await favoriteSong.docs.first.reference.delete();
        isFavorite = false;
      } else {
        await firebaseFirestore
            .collection('Users')
            .doc(uid)
            .collection('Favorites')
            .add({'songId': songId, 'createdAt': Timestamp.now()});
        isFavorite = true;
      }

      return Right(isFavorite);
    } catch (e) {
      return Left('error: $e');
    }
  }

  @override
  Future<bool> isFavoriteSong(String songId) async {
    try {
      final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

      var user = firebaseAuth.currentUser;
      String uid = user!.uid;

      QuerySnapshot favoriteSong = await firebaseFirestore
          .collection('Users')
          .doc(uid)
          .collection('Favorites')
          .where('songId', isEqualTo: songId)
          .get();

      if (favoriteSong.docs.isNotEmpty) {
        return true;
      }

      return false;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<Either<String, List<SongEntity>>> getFavoriteSongs() async {
    try {
      List<SongEntity> favoriteSongs = [];
      final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

      var user = firebaseAuth.currentUser;
      String uid = user!.uid;

      QuerySnapshot favoriteSnapshot = await firebaseFirestore
          .collection('Users')
          .doc(uid)
          .collection('Favorites')
          .get();

      for (var element in favoriteSnapshot.docs) {
        String songId = element['songId'];
        var song = await firebaseFirestore
            .collection('Songs')
            .doc(songId)
            .get();
        SongModel songModel = SongModel.fromJson(song.data()!);
        songModel.id = songId;
        songModel.isFavorite = true;

        favoriteSongs.add(songModel.toEntity());
      }

      return Right(favoriteSongs);
    } catch (e) {
      return Left('error: $e');
    }
  }
}
