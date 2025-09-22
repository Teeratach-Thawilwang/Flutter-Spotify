import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spotify/features/authentication/data/repositories/auth_repository_impl.dart';
import 'package:spotify/features/authentication/data/sources/auth_firebase_service.dart';
import 'package:spotify/features/authentication/domain/repositories/auth_repository.dart';
import 'package:spotify/features/authentication/domain/usecases/signin_usecase.dart';
import 'package:spotify/features/authentication/domain/usecases/signout_usecase.dart';
import 'package:spotify/features/authentication/domain/usecases/signup_usecase.dart';
import 'package:spotify/features/profile/data/repositories/profile_repository_impl.dart';
import 'package:spotify/features/profile/data/sources/profile_local_service.dart';
import 'package:spotify/features/profile/data/sources/profile_remote_service.dart';
import 'package:spotify/features/profile/domain/repositories/profile_repository.dart';
import 'package:spotify/features/profile/domain/usecases/clear_profile_usecase.dart';
import 'package:spotify/features/profile/domain/usecases/get_profile_usecase.dart';
import 'package:spotify/features/song/data/repositories/song_repository_impl.dart';
import 'package:spotify/features/song/data/sources/song_local_service.dart';
import 'package:spotify/features/song/data/sources/song_remote_service.dart';
import 'package:spotify/features/song/domain/repositories/song_repository.dart';
import 'package:spotify/features/song/domain/usecases/add_or_remove_favorite_song.dart';
import 'package:spotify/features/song/domain/usecases/clear_songs.dart';
import 'package:spotify/features/song/domain/usecases/get_favorite_songs.dart';
import 'package:spotify/features/song/domain/usecases/get_new_songs.dart';
import 'package:spotify/features/song/domain/usecases/get_play_list.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  final prefs = await SharedPreferences.getInstance();
  sl.registerSingleton<SharedPreferences>(prefs);

  // Authentication
  sl.registerSingleton<AuthFirebaseService>(AuthFirebaseServiceImpl());
  sl.registerSingleton<AuthRepository>(AuthRepositoryImpl());
  sl.registerSingleton<SignupUsecase>(SignupUsecase());
  sl.registerSingleton<SigninUsecase>(SigninUsecase());
  sl.registerSingleton<SignoutUsecase>(SignoutUsecase());

  // Song: Remote, Local, Repository, Usecase
  sl.registerSingleton<SongRemoteService>(SongRemoteServiceImpl());
  sl.registerSingleton<SongLocalService>(SongLocalServiceImpl(prefs: sl()));
  sl.registerSingleton<SongRepository>(
    SongRepositoryImpl(remoteService: sl(), localService: sl()),
  );
  sl.registerSingleton<GetNewSongsUsecase>(GetNewSongsUsecase());
  sl.registerSingleton<GetPlayListUsecase>(GetPlayListUsecase());
  sl.registerSingleton<AddOrRemoveFavoriteSongUsecase>(
    AddOrRemoveFavoriteSongUsecase(),
  );
  sl.registerSingleton<GetFavoriteSongsUsecase>(GetFavoriteSongsUsecase());
  sl.registerSingleton<ClearSongsUsecase>(ClearSongsUsecase());

  // Profile: Remote, Local, Repository, Usecase
  sl.registerSingleton<ProfileRemoteService>(ProfileRemoteServiceImpl());
  sl.registerSingleton<ProfileLocalService>(
    ProfileLocalServiceImpl(prefs: sl()),
  );
  sl.registerSingleton<ProfileRepository>(
    ProfileRepositoryImpl(remoteService: sl(), localService: sl()),
  );
  sl.registerSingleton<GetProfileUsecase>(GetProfileUsecase());
  sl.registerSingleton<ClearProfileUsecase>(ClearProfileUsecase());
}
