import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify/features/profile/domain/usecases/get_profile_usecase.dart';
import 'package:spotify/features/profile/presentation/bloc/profile_info_state.dart';
import 'package:spotify/service_locator.dart';

class ProfileInfoCubit extends Cubit<ProfileInfoState> {
  ProfileInfoCubit() : super(ProfileInfoLoading());

  Future<void> getProfile() async {
    var profile = await sl<GetProfileUsecase>().call();

    profile.fold(
      (error) => emit(ProfileInfoFailure(errorMessage: error)),
      (profileEntity) => emit(ProfileInfoLoaded(profileEntity: profileEntity)),
    );
  }
}
