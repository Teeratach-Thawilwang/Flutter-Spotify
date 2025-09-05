import 'package:get_it/get_it.dart';
import 'package:spotify/features/authentication/data/repositories/auth_repository_impl.dart';
import 'package:spotify/features/authentication/data/source/auth_firebase_service.dart';
import 'package:spotify/features/authentication/domain/repositories/auth_repository.dart';
import 'package:spotify/features/authentication/domain/usecases/signin_usecase.dart';
import 'package:spotify/features/authentication/domain/usecases/signup_usecase.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  sl.registerSingleton<AuthFirebaseService>(AuthFirebaseServiceImpl());
  sl.registerSingleton<AuthRepository>(AuthRepositoryImpl());
  sl.registerSingleton<SignupUsecase>(SignupUsecase());
  sl.registerSingleton<SigninUsecase>(SigninUsecase());
}
