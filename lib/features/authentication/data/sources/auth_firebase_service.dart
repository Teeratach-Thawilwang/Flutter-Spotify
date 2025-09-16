import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:spotify/features/authentication/data/models/user_model.dart';
import 'package:spotify/features/authentication/domain/entities/user_entity.dart';
import 'package:spotify/features/authentication/domain/params/signin_usecase_params.dart';
import 'package:spotify/features/authentication/domain/params/signup_usecase_params.dart';

abstract class AuthFirebaseService {
  Future<Either<String, UserEntity?>> signin(SigninUsecaseParams params);
  Future<Either<String, UserEntity?>> signup(SignupUsecaseParams params);
  Future<Either<String, UserEntity?>> getCurrentUser();
  Future<Either<String, void>> signout();
}

class AuthFirebaseServiceImpl extends AuthFirebaseService {
  @override
  Future<Either<String, UserEntity?>> signin(SigninUsecaseParams params) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: params.email,
        password: params.password,
      );

      UserEntity? userEntity = await _getCurrentUser();
      return Right(userEntity);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        return Left('The email provided is not found.');
      }
      if (e.code == 'invalid-credential') {
        return Left('Invalid credential.');
      }
      return Left(e.code);
    } catch (e) {
      return Left('error: $e');
    }
  }

  @override
  Future<Either<String, UserEntity?>> signup(SignupUsecaseParams params) async {
    try {
      var data = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: params.email,
        password: params.password,
      );

      FirebaseFirestore.instance.collection('Users').doc(data.user?.uid).set({
        'name': params.fullName,
        'email': data.user?.email,
      });

      UserEntity? userEntity = await _getCurrentUser();
      return Right(userEntity);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return Left('The password provided is too weak.');
      }
      if (e.code == 'email-already-in-use') {
        return Left('An Account already exist.');
      }
      return Left(e.code);
    }
  }

  @override
  Future<Either<String, UserEntity?>> getCurrentUser() async {
    try {
      UserEntity? userEntity = await _getCurrentUser();
      return Right(userEntity);
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<UserEntity?> _getCurrentUser() async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

    var currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      var user = await firebaseFirestore
          .collection('Users')
          .doc(firebaseAuth.currentUser?.uid)
          .get();

      UserModel userModel = UserModel.fromJson(user.data()!);
      userModel.userId = currentUser.uid;
      return userModel.toEntity();
    }
    return null;
  }

  @override
  Future<Either<String, void>> signout() async {
    try {
      FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      await firebaseAuth.signOut();
      return Right(null);
    } catch (e) {
      return Left('error: $e');
    }
  }
}
