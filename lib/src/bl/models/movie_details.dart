import 'package:fav_test_task/src/bl/models/belongs_to_collection.dart';
import 'package:fav_test_task/src/bl/models/genre.dart';
import 'package:fav_test_task/src/bl/models/production_company.dart';
import 'package:fav_test_task/src/bl/models/production_country.dart';
import 'package:fav_test_task/src/bl/models/spoken_language.dart';

/// A class representing the details of a movie.
/// It contains various attributes such as title, overview, release date,
class MovieDetails {
  static const String baseImageUrl = 'https://image.tmdb.org/t/p/w500';

  final bool adult;
  final String? backdropPath;
  final BelongsToCollection? belongsToCollection;
  final int budget;
  final List<Genre> genres;
  final String homepage;
  final int id;
  final String? imdbId;
  final List<String> originCountry;
  final String originalLanguage;
  final String originalTitle;
  final String overview;
  final double popularity;
  final String? posterPath;
  final List<ProductionCompany> productionCompanies;
  final List<ProductionCountry> productionCountries;
  final String releaseDate;
  final int revenue;
  final int runtime;
  final List<SpokenLanguage> spokenLanguages;
  final String status;
  final String tagline;
  final String title;
  final bool video;
  final double voteAverage;
  final int voteCount;

  MovieDetails({
    required this.adult,
    required this.backdropPath,
    required this.belongsToCollection,
    required this.budget,
    required this.genres,
    required this.homepage,
    required this.id,
    required this.imdbId,
    required this.originCountry,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.productionCompanies,
    required this.productionCountries,
    required this.releaseDate,
    required this.revenue,
    required this.runtime,
    required this.spokenLanguages,
    required this.status,
    required this.tagline,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });

  factory MovieDetails.fromJson(Map<String, dynamic> json) {
    return MovieDetails(
      adult: json['adult'],
      backdropPath: json['backdrop_path'],
      belongsToCollection:
          json['belongs_to_collection'] != null
              ? BelongsToCollection.fromJson(json['belongs_to_collection'])
              : null,
      budget: json['budget'],
      genres:
          (json['genres'] as List<dynamic>)
              .map((genre) => Genre.fromJson(genre))
              .toList(),
      homepage: json['homepage'],
      id: json['id'],
      imdbId: json['imdb_id'],
      originCountry: List<String>.from(json['origin_country']),
      originalLanguage: json['original_language'],
      originalTitle: json['original_title'],
      overview: json['overview'],
      popularity: json['popularity'].toDouble(),
      posterPath: json['poster_path'],
      productionCompanies:
          (json['production_companies'] as List<dynamic>)
              .map((company) => ProductionCompany.fromJson(company))
              .toList(),
      productionCountries:
          (json['production_countries'] as List<dynamic>)
              .map((country) => ProductionCountry.fromJson(country))
              .toList(),
      releaseDate: json['release_date'],
      revenue: json['revenue'],
      runtime: json['runtime'],
      spokenLanguages:
          (json['spoken_languages'] as List<dynamic>)
              .map((language) => SpokenLanguage.fromJson(language))
              .toList(),
      status: json['status'],
      tagline: json['tagline'],
      title: json['title'],
      video: json['video'],
      voteAverage: json['vote_average'].toDouble(),
      voteCount: json['vote_count'],
    );
  }

  String get fullPosterPath => '$baseImageUrl$posterPath';
  String get fullBackdropPath => '$baseImageUrl$backdropPath';
}
