import 'package:fav_test_task/src/widgets/components/movie_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fav_test_task/src/bl/providers/liked_movies_provider.dart';

class FavoritesScreen extends ConsumerWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final likedMovies = ref.watch(likedMoviesProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Favorites',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body:
          likedMovies.isEmpty
              ? const Center(
                child: Text(
                  'No favorite movies yet!',
                  style: TextStyle(fontSize: 18),
                ),
              )
              : Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount:
                        MediaQuery.of(context).orientation ==
                                Orientation.portrait
                            ? 2
                            : 4,
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0,
                    childAspectRatio: 0.56,
                  ),
                  itemCount: likedMovies.length,
                  itemBuilder: (context, index) {
                    final movie = likedMovies.elementAt(index);
                    return MovieListItem(movie: movie);
                  },
                ),
              ),
    );
  }
}
