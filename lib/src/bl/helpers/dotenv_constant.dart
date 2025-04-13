import 'package:flutter_dotenv/flutter_dotenv.dart';

/// This enum defines constants for environment variables used in the application.
/// It provides a way to access these variables in a type-safe manner.
enum DotenvConstant {
  moviedbApiKey('MOVIEDB_API_KEY'),
  moviedbBaseUrl('MOVIEDB_API_URL');

  /// The value of the environment variable.
  final String value;

  /// Constructor for the enum.
  /// It initializes the [value] field with the provided string.
  const DotenvConstant(this.value);

  /// Retrieves the value of the environment variable.
  /// Throws an exception if the variable is not found.
  String get getValue {
    final envValue = dotenv.env[value];
    if (envValue == null) {
      throw Exception('Environment variable $value not found');
    }
    return envValue;
  }

  /// Retrieves the value of the environment variable as a nullable string.
  @override
  String toString() => value;
}
