import 'package:fav_test_task/src/bl/providers/moviedb_service_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fav_test_task/src/bl/notifier/movie_details_notifier.dart';

final movieDetailsProvider =
    StateNotifierProvider<MovieDetailsNotifier, MovieDetailsState>((ref) {
      return MovieDetailsNotifier(ref.watch(movieDBApiServiceProvider));
    });
