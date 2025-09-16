import 'package:dartz/dartz.dart';
import 'package:spotify/core/usecase/usecase.dart';
import 'package:spotify/features/authentication/domain/entities/user_entity.dart';
import 'package:spotify/features/authentication/domain/repositories/auth_repository.dart';
import 'package:spotify/service_locator.dart';

class AuthStatusUsecase implements Usecase<Either, dynamic> {
  @override
  Future<Either<String, UserEntity?>> call({params}) async {
    return await sl<AuthRepository>().getCurrentUser();
  }
}
