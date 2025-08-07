import 'package:go_router/go_router.dart';
import 'package:spotify/features/home/presentation/pages/home.dart';
import 'package:spotify/features/splash/presentation/pages/splash.dart';
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
  ],
);
