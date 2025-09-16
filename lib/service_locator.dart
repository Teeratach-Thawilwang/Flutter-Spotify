import 'package:get_it/get_it.dart';
import 'package:spotify/features/authentication/data/repositories/auth_repository_impl.dart';
import 'package:spotify/features/authentication/data/sources/auth_firebase_service.dart';
import 'package:spotify/features/authentication/domain/repositories/auth_repository.dart';
import 'package:spotify/features/authentication/domain/usecases/signin_usecase.dart';
import 'package:spotify/features/authentication/domain/usecases/signout_usecase.dart';
import 'package:spotify/features/authentication/domain/usecases/signup_usecase.dart';
import 'package:spotify/features/profile/data/repositories/profile_repository_impl.dart';
import 'package:spotify/features/profile/data/sources/profile_firebase_service.dart';
import 'package:spotify/features/profile/domain/repositories/profile_repository.dart';
import 'package:spotify/features/profile/domain/usecases/get_profile_usecase.dart';
import 'package:spotify/features/song/data/repositories/song_repository_impl.dart';
import 'package:spotify/features/song/data/sources/song_firebase_service.dart';
import 'package:spotify/features/song/domain/repositories/song_repository.dart';
import 'package:spotify/features/song/domain/usecases/add_or_remove_favorite_song.dart';
import 'package:spotify/features/song/domain/usecases/get_favorite_songs.dart';
import 'package:spotify/features/song/domain/usecases/get_news_songs.dart';
import 'package:spotify/features/song/domain/usecases/get_play_list.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  sl.registerSingleton<AuthFirebaseService>(AuthFirebaseServiceImpl());
  sl.registerSingleton<AuthRepository>(AuthRepositoryImpl());
  sl.registerSingleton<SignupUsecase>(SignupUsecase());
  sl.registerSingleton<SigninUsecase>(SigninUsecase());
  sl.registerSingleton<SignoutUsecase>(SignoutUsecase());

  sl.registerSingleton<SongFirebaseService>(SongFirebaseServiceImpl());
  sl.registerSingleton<SongRepository>(SongRepositoryImpl());
  sl.registerSingleton<GetNewsSongsUsecase>(GetNewsSongsUsecase());
  sl.registerSingleton<GetPlayListUsecase>(GetPlayListUsecase());
  sl.registerSingleton<AddOrRemoveFavoriteSongUsecase>(
    AddOrRemoveFavoriteSongUsecase(),
  );
  sl.registerSingleton<GetFavoriteSongsUsecase>(GetFavoriteSongsUsecase());

  sl.registerSingleton<ProfileFirebaseService>(ProfileFirebaseServiceImpl());
  sl.registerSingleton<ProfileRepository>(ProfileRepositoryImpl());
  sl.registerSingleton<GetProfileUsecase>(GetProfileUsecase());
}
