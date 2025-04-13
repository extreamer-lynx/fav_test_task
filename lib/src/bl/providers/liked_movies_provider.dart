import 'package:fav_test_task/src/bl/models/movie.dart';
import 'package:fav_test_task/src/bl/notifier/liked_movies_notifier.dart';
import 'package:fav_test_task/src/bl/notifier/shared_preferences_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final likedMoviesProvider =
    StateNotifierProvider<LikedMoviesNotifier, Set<Movie>>((ref) {
      return LikedMoviesNotifier(
        sharedPreferences: ref.watch(sharedPreferencesProvider),
      );
    });
