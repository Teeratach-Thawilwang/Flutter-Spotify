import 'package:dartz/dartz.dart';
import 'package:spotify/core/usecase/usecase.dart';
import 'package:spotify/features/authentication/domain/entities/user_entity.dart';
import 'package:spotify/features/authentication/domain/repositories/auth_repository.dart';
import 'package:spotify/features/authentication/domain/params/signin_usecase_params.dart';
import 'package:spotify/service_locator.dart';

class SigninUsecase implements Usecase<Either, SigninUsecaseParams> {
  @override
  Future<Either<String, UserEntity?>> call({
    SigninUsecaseParams? params,
  }) async {
    return await sl<AuthRepository>().signin(params!);
  }
}
