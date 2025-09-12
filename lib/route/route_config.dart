class AppRoutes {
  static const home = _AppRoute(name: 'home', path: '/');
  static const splash = _AppRoute(name: 'splash', path: '/splash');
  static const getStarted = _AppRoute(
    name: 'get-started',
    path: '/get-started',
  );
  static const chooseMode = _AppRoute(
    name: 'choose-mode',
    path: '/choose-mode',
  );
  static const signupOrSignin = _AppRoute(
    name: 'signup-or-signin',
    path: '/signup-or-signin',
  );
  static const signup = _AppRoute(name: 'signup', path: '/signup');
  static const signin = _AppRoute(name: 'signin', path: '/signin');

  static const songPlayer = _AppRoute(name: 'song', path: '/song');
}

class _AppRoute {
  final String name;
  final String path;

  const _AppRoute({required this.name, required this.path});
}
