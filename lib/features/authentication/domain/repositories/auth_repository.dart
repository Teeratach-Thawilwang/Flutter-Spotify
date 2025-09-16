import 'package:dartz/dartz.dart';
import 'package:spotify/features/authentication/domain/entities/user_entity.dart';
import 'package:spotify/features/authentication/domain/params/signin_usecase_params.dart';
import 'package:spotify/features/authentication/domain/params/signup_usecase_params.dart';

abstract class AuthRepository {
  Future<Either<String, UserEntity?>> signin(SigninUsecaseParams params);
  Future<Either<String, UserEntity?>> signup(SignupUsecaseParams params);
  Future<Either<String, UserEntity?>> getCurrentUser();
  Future<Either<String, void>> signout();
}
