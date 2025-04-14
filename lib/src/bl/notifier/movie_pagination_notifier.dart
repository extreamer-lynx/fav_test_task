import 'package:fav_test_task/src/bl/models/movie.dart';
import 'package:fav_test_task/src/bl/services/moviedb_api_service.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// This class manages the state of movie pagination.
/// It extends the [StateNotifier] class from the Riverpod package.
/// It provides a way to fetch movies in a paginated manner,
class MoviePaginationState {
  final List<Movie> movies;
  final int totalPages;
  final bool isLoading;
  final bool hasMore;
  final int currentPage;

  /// Constructs a [MoviePaginationState]
  /// with the given parameters.
  /// The [movies] parameter is a list of movies.
  /// The [isLoading] parameter indicates whether the movies are being loaded.
  /// The [hasMore] parameter indicates whether there are more movies to load.
  /// The [currentPage] parameter indicates the current page of movies.
  /// The [totalPages] parameter indicates the total number of pages of movies.
  MoviePaginationState({
    required this.movies,
    required this.isLoading,
    required this.hasMore,
    required this.currentPage,
    required this.totalPages,
  });

  /// Creates a copy of the current state with the given parameters.
  /// If a parameter is not provided, it will retain its current value.
  /// This is useful for updating the state without mutating the original state.
  MoviePaginationState copyWith({
    List<Movie>? movies,
    bool? isLoading,
    bool? hasMore,
    int? currentPage,
    int? totalPages,
  }) => MoviePaginationState(
    movies: movies ?? this.movies,
    isLoading: isLoading ?? this.isLoading,
    hasMore: hasMore ?? this.hasMore,
    currentPage: currentPage ?? this.currentPage,
    totalPages: totalPages ?? this.totalPages,
  );
}

/// This class is a [StateNotifier] that manages the state of movie pagination.
/// It extends the [StateNotifier] class from the Riverpod package.
/// It fetches movies from the API and updates the state accordingly.
class MoviePaginationNotifier extends StateNotifier<MoviePaginationState> {
  final MovieDBApiService apiService;

  /// Constructs a [MoviePaginationNotifier]
  /// with the given [apiService].
  MoviePaginationNotifier({required this.apiService})
    : super(
        MoviePaginationState(
          movies: [],
          isLoading: false,
          hasMore: true,
          currentPage: 1,
          totalPages: 0,
        ),
      ) {
    fetchMovies();
  }

  /// Fetches movies from the API.
  /// If [paginate] is true, it fetches the next page of movies.
  /// If [paginate] is false, it fetches the first page of movies.
  Future<void> fetchMovies({bool paginate = true}) async {
    if (state.currentPage == state.totalPages) return;
    if (state.isLoading || (!state.hasMore && paginate)) return;

    state = state.copyWith(
      isLoading: true,
      movies: paginate ? state.movies : [],
    );

    try {
      final response = await apiService.fetchMovies(
        paginate ? state.currentPage : 1,
      );

      if (response.results.isEmpty) {
        state = state.copyWith(hasMore: false);
      } else {
        state = state.copyWith(
          movies:
              paginate
                  ? [...state.movies, ...response.results]
                  : response.results,
          currentPage: (paginate ? state.currentPage : 1) + 1,
          totalPages: response.totalPages,
          hasMore: state.currentPage <= response.totalPages,
        );
      }
    } catch (e) {
      debugPrint('Error: $e');
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  /// Searches for movies based on the given [query].
  /// If [paginate] is true, it fetches the next page of movies.
  /// If [paginate] is false, it fetches the first page of movies.
  Future<void> searchMovies(String query, {bool paginate = true}) async {
    if (state.currentPage == state.totalPages) return;
    if (state.isLoading || (!state.hasMore && paginate)) return;

    state = state.copyWith(
      isLoading: true,
      movies: paginate ? state.movies : [],
    );

    try {
      final response = await apiService.searchMovies(
        query,
        page: paginate ? state.currentPage : 1,
      );

      if (response.results.isEmpty) {
        state = state.copyWith(hasMore: false);
      } else {
        state = state.copyWith(
          movies:
              paginate
                  ? [...state.movies, ...response.results]
                  : response.results,
          currentPage: (paginate ? state.currentPage : 1) + 1,
          totalPages: response.totalPages,
          hasMore: state.currentPage <= response.totalPages,
        );
      }
    } catch (e) {
      debugPrint('Error: $e');
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }
}
