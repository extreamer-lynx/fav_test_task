import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fav_test_task/src/bl/models/movie_details.dart';
import 'package:fav_test_task/src/bl/services/moviedb_api_service.dart';

/// State class to hold the state of movie details
/// including the movie details, loading state, and error message.
class MovieDetailsState {
  final MovieDetails? movieDetails;
  final bool isLoading;
  final String? error;

  /// Constructor for [MovieDetailsState].
  /// Takes an optional [MovieDetails] object, a loading state, and an error message.
  MovieDetailsState({this.movieDetails, this.isLoading = false, this.error});

  /// Factory constructor to create a new instance of [MovieDetailsState]
  /// with the same values as the current instance.
  MovieDetailsState copyWith({
    MovieDetails? movieDetails,
    bool? isLoading,
    String? error,
  }) {
    return MovieDetailsState(
      movieDetails: movieDetails ?? this.movieDetails,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

/// This class is a [StateNotifier] that manages the state of movie details.
/// It fetches movie details from the API and updates the state accordingly.
class MovieDetailsNotifier extends StateNotifier<MovieDetailsState> {
  final MovieDBApiService apiService;

  /// Constructs a [MovieDetailsNotifier]
  /// with the given [apiService].
  MovieDetailsNotifier(this.apiService) : super(MovieDetailsState());

  /// Fetches movie details for a given [movieId].
  /// Updates the state to indicate loading and handles errors.
  /// If successful, updates the state with the fetched movie details.
  Future<void> fetchMovieDetails(int movieId) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final movieDetails = await apiService.fetchMovieDetails(movieId);
      state = state.copyWith(movieDetails: movieDetails, isLoading: false);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Failed to fetch movie details',
      );
    }
  }
}
