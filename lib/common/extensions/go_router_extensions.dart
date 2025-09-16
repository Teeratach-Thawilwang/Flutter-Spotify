import 'package:go_router/go_router.dart';

extension GoRouterExtension on GoRouter {
  void popUntilPath(String ancestorPath) {
    while (routerDelegate.currentConfiguration.matches.last.matchedLocation !=
        ancestorPath) {
      if (!canPop()) {
        return;
      }
      pop();
    }
  }

  List readPaths() {
    return routerDelegate.currentConfiguration.matches
        .map((routeMatch) {
          final route = routeMatch.route;
          if (route is GoRoute) {
            return {'name': route.name, 'path': route.path};
          }
          return null;
        })
        .whereType<Map<String, String?>>()
        .toList();
  }
}
