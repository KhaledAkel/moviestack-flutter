import 'package:go_router/go_router.dart';
import 'package:moviestack/views/pages/index.dart'
    show SplashPage, PopularNowPage, SearchPage;

final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => SplashPage(),
    ),
    GoRoute(
      path: '/popular-now',
      builder: (context, state) => PopularNowPage(),
    ),
    GoRoute(
      path: '/search',
      builder: (context, state) => SearchPage(),
    ),
  ],
);
