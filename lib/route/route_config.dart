class AppRoutes {
  static const home = _AppRoute(name: 'home', path: '/');
  static const splash = _AppRoute(name: 'splash', path: '/splash');
}

class _AppRoute {
  final String name;
  final String path;

  const _AppRoute({required this.name, required this.path});
}
