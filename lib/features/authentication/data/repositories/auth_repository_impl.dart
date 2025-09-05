import 'package:dartz/dartz.dart';
import 'package:spotify/features/authentication/data/source/auth_firebase_service.dart';
import 'package:spotify/features/authentication/domain/params/signin_usecase_params.dart';
import 'package:spotify/features/authentication/domain/params/signup_usecase_params.dart';
import 'package:spotify/features/authentication/domain/repositories/auth_repository.dart';
import 'package:spotify/service_locator.dart';

class AuthRepositoryImpl extends AuthRepository {
  @override
  Future<Either<String, String>> signin(SigninUsecaseParams params) async {
    return await sl<AuthFirebaseService>().signin(params);
  }

  @override
  Future<Either<String, String>> signup(SignupUsecaseParams params) async {
    return await sl<AuthFirebaseService>().signup(params);
  }
}
