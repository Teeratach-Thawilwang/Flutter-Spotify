import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:spotify/features/profile/data/models/profile_model.dart';

abstract class ProfileRemoteService {
  Future<Either<String, ProfileModel>> getProfile();
}

class ProfileRemoteServiceImpl extends ProfileRemoteService {
  @override
  Future<Either<String, ProfileModel>> getProfile() async {
    try {
      FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

      var user = await firebaseFirestore
          .collection('Users')
          .doc(firebaseAuth.currentUser?.uid)
          .get();

      ProfileModel profileModel = ProfileModel.fromJson(user.data()!);
      profileModel.imageUrl = firebaseAuth.currentUser?.photoURL;
      return Right(profileModel);
    } catch (e) {
      return Left('error: $e');
    }
  }
}
