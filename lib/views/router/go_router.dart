import 'package:go_router/go_router.dart';
import 'package:moviestack/views/pages/index.dart'
    show
        SplashPage,
        PopularNowPage,
        SearchPage,
        MovieDetailsPage,
        TvShowDetailsPage,
        ActorDetailsPage,
        ProfilePage;

final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => SplashPage()),
    GoRoute(
        path: '/popular-now', builder: (context, state) => PopularNowPage()),
    GoRoute(path: '/search', builder: (context, state) => SearchPage()),
    GoRoute(
      path: '/movie/:id',
      builder: (context, state) =>
          MovieDetailsPage(movieId: int.parse(state.pathParameters['id']!)),
    ),
    GoRoute(
      path: '/tv-show/:id',
      builder: (context, state) =>
          TvShowDetailsPage(tvShowId: int.parse(state.pathParameters['id']!)),
    ),
    GoRoute(
      path: '/actor/:id',
      builder: (context, state) =>
          ActorDetailsPage(actorId: int.parse(state.pathParameters['id']!)),
    ),
    GoRoute(path: '/profile', builder: (context, state) => ProfilePage()),
  ],
);
