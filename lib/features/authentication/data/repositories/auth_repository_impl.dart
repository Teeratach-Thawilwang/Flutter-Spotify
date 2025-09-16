import 'package:dartz/dartz.dart';
import 'package:spotify/features/authentication/data/sources/auth_firebase_service.dart';
import 'package:spotify/features/authentication/domain/entities/user_entity.dart';
import 'package:spotify/features/authentication/domain/params/signin_usecase_params.dart';
import 'package:spotify/features/authentication/domain/params/signup_usecase_params.dart';
import 'package:spotify/features/authentication/domain/repositories/auth_repository.dart';
import 'package:spotify/service_locator.dart';

class AuthRepositoryImpl extends AuthRepository {
  @override
  Future<Either<String, UserEntity?>> signin(SigninUsecaseParams params) async {
    return await sl<AuthFirebaseService>().signin(params);
  }

  @override
  Future<Either<String, UserEntity?>> signup(SignupUsecaseParams params) async {
    return await sl<AuthFirebaseService>().signup(params);
  }

  @override
  Future<Either<String, UserEntity?>> getCurrentUser() async {
    return await sl<AuthFirebaseService>().getCurrentUser();
  }

  @override
  Future<Either<String, void>> signout() async {
    return await sl<AuthFirebaseService>().signout();
  }
}
