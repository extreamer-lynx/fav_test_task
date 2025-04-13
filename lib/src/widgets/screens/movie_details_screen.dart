import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fav_test_task/src/bl/providers/movie_details_provider.dart';

/// A screen that displays the details of a movie.
/// It fetches the movie details using the [movieDetailsProvider] and
/// displays them in a scrollable view.
class MovieDetailsScreen extends ConsumerStatefulWidget {
  /// The ID of the movie to display details for.
  /// This ID is passed to the [movieDetailsProvider] to fetch the movie details.
  final int movieId;

  /// Constructs a [MovieDetailsScreen]
  const MovieDetailsScreen({super.key, required this.movieId});

  @override
  ConsumerState<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends ConsumerState<MovieDetailsScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(movieDetailsProvider.notifier).fetchMovieDetails(widget.movieId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final movieDetailsState = ref.watch(movieDetailsProvider);

    if (movieDetailsState.isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (movieDetailsState.error != null) {
      return Scaffold(
        body: Center(
          child: Text(
            movieDetailsState.error!,
            style: const TextStyle(color: Colors.red),
          ),
        ),
      );
    }

    if (movieDetailsState.movieDetails == null) {
      return const Scaffold(
        body: Center(
          child: Text(
            'No movie details available.',
            style: TextStyle(fontSize: 16),
          ),
        ),
      );
    }

    final movieDetails = movieDetailsState.movieDetails!;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300.0,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  movieDetails.title,
                  style: const TextStyle(
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        blurRadius: 10.0,
                        color: Colors.black,
                        offset: Offset(0, 1),
                      ),
                    ],
                  ),
                ),
              ),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    movieDetails.fullBackdropPath,
                    fit: BoxFit.cover,
                  ),
                  const DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.black54, Colors.transparent],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movieDetails.overview,
                    style: const TextStyle(fontSize: 16, height: 1.5),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Release Date: ${movieDetails.releaseDate}',
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Runtime: ${movieDetails.runtime} min',
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Genres: ${movieDetails.genres.map((genre) => genre.name).join(', ')}',
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Rating: ${movieDetails.voteAverage} (${movieDetails.voteCount} votes)',
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Budget: \$${movieDetails.budget}',
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Revenue: \$${movieDetails.revenue}',
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Production Companies: ${movieDetails.productionCompanies.map((company) => company.name).join(', ')}',
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Production Countries: ${movieDetails.productionCountries.map((country) => country.name).join(', ')}',
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Spoken Languages: ${movieDetails.spokenLanguages.map((language) => language.name).join(', ')}',
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Tagline: ${movieDetails.tagline}',
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Homepage: ${movieDetails.homepage}',
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Original Language: ${movieDetails.originalLanguage}',
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Original Title: ${movieDetails.originalTitle}',
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'IMDB ID: ${movieDetails.imdbId}',
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Origin Country: ${movieDetails.originCountry.join(', ')}',
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Adult: ${movieDetails.adult ? 'Yes' : 'No'}',
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Video: ${movieDetails.video ? 'Yes' : 'No'}',
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Popularity: ${movieDetails.popularity}',
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Vote Count: ${movieDetails.voteCount}',
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Belongs to Collection: ${movieDetails.belongsToCollection?.name ?? 'N/A'}',
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Status: ${movieDetails.status}',
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
