import 'package:fav_test_task/src/bl/models/movie.dart';

/// A class representing a paginated list of movies.
/// It contains the current page number, a list of movies, total pages,
class MoviePaginationList {
  final int page;
  final List<Movie> results;
  final int totalPages;
  final int totalResults;

  MoviePaginationList({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory MoviePaginationList.fromJson(Map<String, dynamic> json) {
    return MoviePaginationList(
      page: json['page'],
      results: (json['results'] as List).map((i) => Movie.fromJson(i)).toList(),
      totalPages: json['total_pages'],
      totalResults: json['total_results'],
    );
  }
}
