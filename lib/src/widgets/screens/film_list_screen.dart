import 'package:fav_test_task/gen/assets.gen.dart';
import 'package:fav_test_task/src/bl/providers/movie_pagination_provider.dart';
import 'package:fav_test_task/src/bl/providers/theme_provider.dart';
import 'package:fav_test_task/src/widgets/components/movie_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:svg_image/svg_image.dart';

/// A screen that displays a list of movies.
/// It allows users to search for movies and view their details.
/// The screen uses a [GridView] to display the movies in a grid format.
class FilmListScreen extends ConsumerStatefulWidget {
  /// Constructs a [FilmListScreen] widget.
  /// The [key] parameter is optional and can be used to identify the widget.
  const FilmListScreen({super.key});

  @override
  FilmListScreenState createState() => FilmListScreenState();
}

class FilmListScreenState extends ConsumerState<FilmListScreen> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();

  void _scrollListener() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 300) {
      if (_searchController.text == '') {
        ref.read(moviePaginationProvider.notifier).fetchMovies();
      } else {
        ref
            .read(moviePaginationProvider.notifier)
            .searchMovies(_searchController.text);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _showSearchDialog(
    BuildContext context,
    TextEditingController searchController,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Search Movies'),
          content: TextField(
            controller: searchController,
            decoration: const InputDecoration(hintText: 'Enter movie name'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                final searchQuery = searchController.text.trim();
                if (searchQuery.isNotEmpty) {
                  ref
                      .read(moviePaginationProvider.notifier)
                      .searchMovies(searchQuery, paginate: false);
                }
                if (searchQuery.isEmpty) {
                  ref
                      .read(moviePaginationProvider.notifier)
                      .fetchMovies(paginate: false);
                }
                Navigator.of(context).pop();
              },
              child: const Text('Search'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final availableMovies = ref.watch(moviePaginationProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text("Movie", style: Theme.of(context).textTheme.headlineMedium),
        actions: [
          IconButton(
            icon: Icon(Icons.star, size: 36),
            onPressed: () {
              context.go("/favorites");
            },
          ),
          IconButton(
            icon: Icon(Icons.cancel_outlined, size: 36),
            onPressed: () {
              _searchController.clear();
              ref
                  .read(moviePaginationProvider.notifier)
                  .fetchMovies(paginate: false);
            },
          ),
          IconButton(
            icon: SvgImage(
              Assets.svg.search,
              type: PathType.assets,
              color: Theme.of(context).appBarTheme.foregroundColor,
            ),
            onPressed: () {
              _showSearchDialog(context, _searchController);
            },
          ),
          IconButton(
            icon:
                Theme.of(context).brightness == Brightness.dark
                    ? SvgImage(
                      Assets.svg.moon,
                      type: PathType.assets,
                      color: Theme.of(context).appBarTheme.foregroundColor,
                    )
                    : SvgImage(
                      Assets.svg.sun,
                      type: PathType.assets,
                      color: Theme.of(context).appBarTheme.foregroundColor,
                    ),
            onPressed: () {
              ref.read(themeProvider.notifier).toggleTheme();
            },
          ),
        ],
      ),
      body: GridView.builder(
        controller: _scrollController,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount:
              MediaQuery.of(context).orientation == Orientation.portrait
                  ? 2
                  : 4,
          childAspectRatio: 0.56,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
        ),
        padding: const EdgeInsets.all(8),
        itemCount: availableMovies.movies.length + 1,
        itemBuilder: (context, index) {
          if (!availableMovies.hasMore) {
            return const SizedBox.shrink();
          }

          if (index == availableMovies.movies.length) {
            return const Center(child: CircularProgressIndicator());
          }

          return MovieListItem(movie: availableMovies.movies[index]);
        },
      ),
    );
  }
}
