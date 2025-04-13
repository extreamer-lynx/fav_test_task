import 'package:dio/dio.dart';
import 'package:fav_test_task/src/bl/helpers/dotenv_constant.dart';
import 'package:fav_test_task/src/bl/models/movie_details.dart';
import 'package:fav_test_task/src/bl/models/movie_pagination_list.dart';

/// A service class to interact with the MovieDB API.
/// It provides methods to fetch movies, search for movies, and fetch movie details.
class MovieDBApiService {
  late final Dio _dio;

  /// Constructor for [MovieDBApiService].
  /// Initializes the Dio instance with base options including headers and base URL.
  MovieDBApiService() {
    _dio = Dio(
      BaseOptions(
        headers: {
          'Authorization': "Bearer ${DotenvConstant.moviedbApiKey.getValue}",
        },
        baseUrl: DotenvConstant.moviedbBaseUrl.getValue,
      ),
    );
  }

  /// Fetches a list of movies from the MovieDB API.
  /// Takes a [page] parameter to specify the page number.
  /// Returns a [MoviePaginationList] object containing the list of movies.
  Future<MoviePaginationList> fetchMovies(int page) async {
    try {
      final response = await _dio.get(
        '/discover/movie',
        queryParameters: {'page': page},
      );
      return MoviePaginationList.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  /// Searches for movies based on a [query] string.
  /// Takes an optional [page] parameter to specify the page number.
  /// Returns a [MoviePaginationList] object containing the list of movies.
  Future<MoviePaginationList> searchMovies(String query, {int page = 1}) async {
    try {
      final response = await _dio.get(
        '/search/movie',
        queryParameters: {'query': query, 'page': page},
      );
      return MoviePaginationList.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  /// Fetches detailed information about a movie based on its [movieId].
  /// Returns a [MovieDetails] object containing the movie details.
  /// [movieId] is the ID of the movie to fetch details for.
  Future<MovieDetails> fetchMovieDetails(int movieId) async {
    try {
      final response = await _dio.get('/movie/$movieId');
      return MovieDetails.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }
}
