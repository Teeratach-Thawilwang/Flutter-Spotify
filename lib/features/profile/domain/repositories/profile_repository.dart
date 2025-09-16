import 'package:dartz/dartz.dart';
import 'package:spotify/features/profile/domain/entities/profile_entity.dart';

abstract class ProfileRepository {
  Future<Either<String, ProfileEntity>> getProfile();
}
