import 'package:fav_test_task/src/bl/services/moviedb_api_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final movieDBApiServiceProvider = Provider<MovieDBApiService>((ref) {
  return MovieDBApiService();
});
