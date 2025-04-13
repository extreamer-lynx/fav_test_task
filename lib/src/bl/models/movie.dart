/// This file contains the Movie class, which represents a movie object
/// in the application. It includes methods to create a Movie object from JSON data,
class Movie {
  static const String baseImageUrl = 'https://image.tmdb.org/t/p/w500';

  final int id;
  final String title;
  final String? posterPath;
  final String rating;

  Movie({
    required this.id,
    required this.title,
    required this.posterPath,
    required this.rating,
  });

  String get fullPosterPath => '$baseImageUrl$posterPath';

  factory Movie.fromJson(Map<String, dynamic> json) => Movie(
    id: json['id'],
    title: json['title'],
    posterPath: json['poster_path'],
    rating: json['vote_average'].toString(),
  );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Movie && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'poster_path': posterPath,
      'vote_average': rating,
    };
  }
}
