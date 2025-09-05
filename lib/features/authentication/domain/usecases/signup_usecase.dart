import 'package:dartz/dartz.dart';
import 'package:spotify/core/usecase/usecase.dart';
import 'package:spotify/features/authentication/domain/params/signup_usecase_params.dart';
import 'package:spotify/features/authentication/domain/repositories/auth_repository.dart';
import 'package:spotify/service_locator.dart';

class SignupUsecase implements Usecase<Either, SignupUsecaseParams> {
  @override
  Future<Either> call({SignupUsecaseParams? params}) {
    return sl<AuthRepository>().signup(params!);
  }
}
