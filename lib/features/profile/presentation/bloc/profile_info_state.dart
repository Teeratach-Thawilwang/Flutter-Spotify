import 'package:spotify/features/profile/domain/entities/profile_entity.dart';

abstract class ProfileInfoState {}

class ProfileInfoLoading extends ProfileInfoState {}

class ProfileInfoLoaded extends ProfileInfoState {
  final ProfileEntity profileEntity;
  ProfileInfoLoaded({required this.profileEntity});
}

class ProfileInfoFailure extends ProfileInfoState {
  final String errorMessage;
  ProfileInfoFailure({required this.errorMessage});
}
