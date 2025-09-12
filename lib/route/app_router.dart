import 'package:go_router/go_router.dart';
import 'package:spotify/features/authentication/presentation/pages/signin.dart';
import 'package:spotify/features/authentication/presentation/pages/signup.dart';
import 'package:spotify/features/authentication/presentation/pages/signup_or_signin.dart';
import 'package:spotify/features/song/domain/entities/song_entity.dart';
import 'package:spotify/features/song/presentation/pages/song_player.dart';
import 'package:spotify/pages/home.dart';
import 'package:spotify/pages/choose_mode.dart';
import 'package:spotify/pages/get_started.dart';
import 'package:spotify/pages/splash.dart';
import 'package:spotify/route/route_config.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: AppRoutes.splash.path,
  routes: [
    GoRoute(
      name: AppRoutes.splash.name,
      path: AppRoutes.splash.path,
      builder: (context, state) => const SplashPage(),
    ),
    GoRoute(
      name: AppRoutes.home.name,
      path: AppRoutes.home.path,
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      name: AppRoutes.getStarted.name,
      path: AppRoutes.getStarted.path,
      builder: (context, state) => GetStartedPage(),
    ),
    GoRoute(
      name: AppRoutes.chooseMode.name,
      path: AppRoutes.chooseMode.path,
      builder: (context, state) => ChooseModePage(),
    ),
    GoRoute(
      name: AppRoutes.signupOrSignin.name,
      path: AppRoutes.signupOrSignin.path,
      builder: (context, state) => SignupOrSigninPage(),
    ),
    GoRoute(
      name: AppRoutes.signup.name,
      path: AppRoutes.signup.path,
      builder: (context, state) => SignupPage(),
    ),
    GoRoute(
      name: AppRoutes.signin.name,
      path: AppRoutes.signin.path,
      builder: (context, state) => SigninPage(),
    ),
    GoRoute(
      name: AppRoutes.songPlayer.name,
      path: AppRoutes.songPlayer.path,
      builder: (context, state) {
        final song = state.extra as SongEntity;
        return SongPlayer(songEntity: song);
      },
    ),
  ],
);
