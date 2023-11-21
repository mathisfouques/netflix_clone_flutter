import 'package:equatable/equatable.dart';

/// The genre of the movie or tvShow. Can be "Action", "Adventure", etc. Refers the id of the genre.
class Genre extends Equatable {
  /// The ID of the genre in the TMDb database.
  final int id;

  /// Type of the genre: can be a movie or a TV show.
  final GenreType type;

  /// Name of the genre in English.
  final String title;

  const Genre({
    required this.id,
    required this.type,
    required this.title,
  });

  @override
  List<Object?> get props => [id, type, title];

  @override
  String toString() {
    return 'Genre(${type.name}) : $title';
  }

  Genre copyWith({
    int? id,
    GenreType? type,
    String? title,
  }) {
    return Genre(
      id: id ?? this.id,
      type: type ?? this.type,
      title: title ?? this.title,
    );
  }
}

/// Type of the genre: is either a movie or a TV show.
enum GenreType {
  movie,
  tvShow,
}
