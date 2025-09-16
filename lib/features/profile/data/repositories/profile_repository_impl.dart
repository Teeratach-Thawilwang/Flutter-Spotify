import 'package:dartz/dartz.dart';
import 'package:spotify/features/profile/data/sources/profile_firebase_service.dart';
import 'package:spotify/features/profile/domain/entities/profile_entity.dart';
import 'package:spotify/features/profile/domain/repositories/profile_repository.dart';
import 'package:spotify/service_locator.dart';

class ProfileRepositoryImpl extends ProfileRepository {
  @override
  Future<Either<String, ProfileEntity>> getProfile() async {
    return await sl<ProfileFirebaseService>().getProfile();
  }
}
