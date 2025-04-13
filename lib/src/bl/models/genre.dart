/// This file contains the Genre class which represents a genre in the application.
/// It includes methods to create a Genre object from JSON data.
class Genre {
  /// The ID of the genre.
  final int id;

  /// The name of the genre.
  final String name;

  Genre({required this.id, required this.name});

  factory Genre.fromJson(Map<String, dynamic> json) {
    return Genre(id: json['id'], name: json['name']);
  }
}
