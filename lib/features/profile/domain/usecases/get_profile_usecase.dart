import 'package:dartz/dartz.dart';
import 'package:spotify/core/usecase/usecase.dart';
import 'package:spotify/features/profile/domain/entities/profile_entity.dart';
import 'package:spotify/features/profile/domain/repositories/profile_repository.dart';
import 'package:spotify/service_locator.dart';

class GetProfileUsecase implements Usecase<Either, dynamic> {
  @override
  Future<Either<String, ProfileEntity>> call({params}) async {
    return await sl<ProfileRepository>().getProfile();
  }
}
