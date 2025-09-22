import 'package:dartz/dartz.dart';
import 'package:spotify/features/profile/data/sources/profile_local_service.dart';
import 'package:spotify/features/profile/data/sources/profile_remote_service.dart';
import 'package:spotify/features/profile/domain/entities/profile_entity.dart';
import 'package:spotify/features/profile/domain/repositories/profile_repository.dart';

class ProfileRepositoryImpl extends ProfileRepository {
  final ProfileRemoteService remoteService;
  final ProfileLocalService localService;

  ProfileRepositoryImpl({
    required this.remoteService,
    required this.localService,
  });

  @override
  Future<Either<String, ProfileEntity>> getProfile() async {
    final cacheProfile = await localService.getProfile();
    if (cacheProfile != null) {
      return Right(cacheProfile.toEntity());
    }

    final result = await remoteService.getProfile();
    return result.fold(
      (l) {
        return Left(l);
      },
      (profileModel) async {
        await localService.setProfile(profileModel);
        ProfileEntity profileEntity = profileModel.toEntity();
        return Right(profileEntity);
      },
    );
  }

  @override
  Future<void> clearProfile() async {
    await localService.clearProfile();
  }
}
