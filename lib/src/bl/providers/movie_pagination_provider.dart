import 'package:fav_test_task/src/bl/notifier/movie_pagination_notifier.dart';
import 'package:fav_test_task/src/bl/providers/moviedb_service_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final moviePaginationProvider =
    StateNotifierProvider<MoviePaginationNotifier, MoviePaginationState>(
      (ref) => MoviePaginationNotifier(
        apiService: ref.watch(movieDBApiServiceProvider),
      ),
    );
