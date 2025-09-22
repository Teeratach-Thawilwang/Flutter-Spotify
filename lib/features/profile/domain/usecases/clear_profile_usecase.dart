import 'package:spotify/core/usecase/usecase.dart';
import 'package:spotify/features/profile/domain/repositories/profile_repository.dart';
import 'package:spotify/service_locator.dart';

class ClearProfileUsecase implements Usecase<void, dynamic> {
  @override
  Future<void> call({params}) async {
    return await sl<ProfileRepository>().clearProfile();
  }
}
