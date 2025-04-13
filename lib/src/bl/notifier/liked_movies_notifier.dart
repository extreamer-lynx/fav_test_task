import 'package:fav_test_task/src/bl/models/movie.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

/// This class manages the state of liked movies using Riverpod's StateNotifier.
/// It allows toggling the like status of movies and persists the state
/// using SharedPreferences.
class LikedMoviesNotifier extends StateNotifier<Set<Movie>> {
  static const _likedMoviesKey = 'liked_movies';
  final SharedPreferences sharedPreferences;

  /// Constructor for [LikedMoviesNotifier].
  /// It initializes the state and loads the liked movies from SharedPreferences.
  LikedMoviesNotifier({required this.sharedPreferences}) : super({}) {
    _loadLikedMovies();
  }

  /// Loads the liked movies from SharedPreferences.
  Future<void> _loadLikedMovies() async {
    final likedMoviesJson =
        sharedPreferences.getStringList(_likedMoviesKey) ?? [];
    final likedMovies =
        likedMoviesJson
            .map((movieJson) => Movie.fromJson(jsonDecode(movieJson)))
            .toSet();
    state = likedMovies;
  }

  /// Saves the liked movies to SharedPreferences.
  Future<void> _saveLikedMovies() async {
    final likedMoviesJson =
        state.map((movie) => jsonEncode(movie.toJson())).toList();
    await sharedPreferences.setStringList(_likedMoviesKey, likedMoviesJson);
  }

  /// Toggles the like status of a movie.
  Future<void> toggleLike(Movie movie) async {
    if (state.contains(movie)) {
      state = {...state}..remove(movie);
    } else {
      state = {...state}..add(movie);
    }
    await _saveLikedMovies();
  }

  /// Checks if a movie is liked.
  bool isLiked(Movie movie) => state.contains(movie);
}
