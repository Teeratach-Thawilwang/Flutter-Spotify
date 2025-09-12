import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:spotify/features/authentication/domain/params/signin_usecase_params.dart';
import 'package:spotify/features/authentication/domain/params/signup_usecase_params.dart';

abstract class AuthFirebaseService {
  Future<Either<String, String>> signin(SigninUsecaseParams params);
  Future<Either<String, String>> signup(SignupUsecaseParams params);
}

class AuthFirebaseServiceImpl extends AuthFirebaseService {
  @override
  Future<Either<String, String>> signin(SigninUsecaseParams params) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: params.email,
        password: params.password,
      );

      return Right('Signin was successful.');
    } on FirebaseAuthException catch (e) {
      debugPrint(e.code);
      if (e.code == 'invalid-email') {
        return Left('The email provided is not found.');
      }
      if (e.code == 'invalid-credential') {
        return Left('Invalid credential.');
      }
      return Left(e.code);
    }
  }

  @override
  Future<Either<String, String>> signup(SignupUsecaseParams params) async {
    try {
      var data = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: params.email,
        password: params.password,
      );

      FirebaseFirestore.instance.collection('Users').doc(data.user?.uid).set({
        'name': params.fullName,
        'email': data.user?.email,
      });

      return Right('Signup was successful.');
    } on FirebaseAuthException catch (e) {
      debugPrint(e.code);
      if (e.code == 'weak-password') {
        return Left('The password provided is too weak.');
      }
      if (e.code == 'email-already-in-use') {
        return Left('An Account already exist.');
      }
      return Left(e.code);
    }
  }
}
