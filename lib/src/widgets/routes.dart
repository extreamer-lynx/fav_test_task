import 'package:fav_test_task/src/widgets/screens/favorites_screen.dart';
import 'package:fav_test_task/src/widgets/screens/movie_details_screen.dart';
import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

import 'screens/film_list_screen.dart';

/// The route configuration.
final GoRouter router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState mainState) {
        return FilmListScreen();
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'details',
          builder:
              (BuildContext context, GoRouterState state) =>
                  MovieDetailsScreen(movieId: state.extra as int),
        ),
        GoRoute(
          path: 'favorites',
          builder:
              (BuildContext context, GoRouterState state) => FavoritesScreen(),
        ),
      ],
    ),
  ],
);
