import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:spotify/features/profile/data/models/profile_model.dart';
import 'package:spotify/features/profile/domain/entities/profile_entity.dart';

abstract class ProfileFirebaseService {
  Future<Either<String, ProfileEntity>> getProfile();
}

class ProfileFirebaseServiceImpl extends ProfileFirebaseService {
  @override
  Future<Either<String, ProfileEntity>> getProfile() async {
    try {
      FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

      var user = await firebaseFirestore
          .collection('Users')
          .doc(firebaseAuth.currentUser?.uid)
          .get();

      ProfileModel profileModel = ProfileModel.fromJson(user.data()!);
      profileModel.imageUrl = firebaseAuth.currentUser?.photoURL;

      ProfileEntity profileEntity = profileModel.toEntity();
      return Right(profileEntity);
    } catch (e) {
      return Left('error: $e');
    }
  }
}
