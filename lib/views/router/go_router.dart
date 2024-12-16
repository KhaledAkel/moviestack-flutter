import 'package:go_router/go_router.dart';
import 'package:moviestack/views/pages/index.dart' show SplashPage;

final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => SplashPage(),
    ),
  ],
);
