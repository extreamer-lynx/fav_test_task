import 'package:fav_test_task/src/bl/models/movie.dart';
import 'package:fav_test_task/src/bl/providers/liked_movies_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// A widget that displays a movie item in a list.
/// It shows the movie's poster, title, and rating.
/// Tapping on the item navigates to the movie details screen.
/// The movie is passed as a parameter to the widget.
class MovieListItem extends ConsumerWidget {
  /// Constructs a [MovieListItem] widget.
  /// The [movie] parameter is required and represents the movie to be displayed.
  /// The [key] parameter is optional and can be used to identify the widget.
  const MovieListItem({super.key, required this.movie});

  /// The movie to be displayed.
  /// This parameter is required and cannot be null.
  final Movie movie;

  @override
  Widget build(BuildContext context, WidgetRef ref) => GestureDetector(
    onTap: () {
      context.go('/details', extra: movie.id);
    },
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AspectRatio(
          aspectRatio: 0.7,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Stack(
              children: [
                Positioned.fill(
                  child:
                      movie.posterPath != null
                          ? Image.network(movie.fullPosterPath)
                          : const Center(child: Text('No Image Available')),
                ),
                Positioned(
                  top: 3,
                  right: 3,
                  child: IconButton(
                    onPressed: () {
                      ref.read(likedMoviesProvider.notifier).toggleLike(movie);
                    },
                    icon: Icon(
                      Icons.star,
                      color:
                          ref.watch(likedMoviesProvider).contains(movie)
                              ? Colors.yellow
                              : Colors.black45,
                      size: 40,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          movie.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.left,
          style: Theme.of(context).textTheme.labelMedium,
        ),
        const SizedBox(height: 8),
        Text(
          "Rating: ${movie.rating}",
          style: Theme.of(context).textTheme.labelSmall,
        ),
      ],
    ),
  );
}
