import 'package:dartz/dartz.dart';
import 'package:spotify/core/usecase/usecase.dart';
import 'package:spotify/features/authentication/domain/repositories/auth_repository.dart';
import 'package:spotify/service_locator.dart';

class SignoutUsecase implements Usecase<Either, dynamic> {
  @override
  Future<Either<String, void>> call({params}) async {
    return await sl<AuthRepository>().signout();
  }
}
