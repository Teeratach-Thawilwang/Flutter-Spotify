import 'package:dartz/dartz.dart';
import 'package:spotify/features/authentication/domain/params/signin_usecase_params.dart';
import 'package:spotify/features/authentication/domain/params/signup_usecase_params.dart';

abstract class AuthRepository {
  Future<Either<String, String>> signin(SigninUsecaseParams params);
  Future<Either<String, String>> signup(SignupUsecaseParams params);
}
