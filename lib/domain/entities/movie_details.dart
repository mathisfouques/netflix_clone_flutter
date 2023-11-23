import 'package:equatable/equatable.dart';

import 'genre.dart';

/// Assemble all information about one movie: date, realization, description, etc.
///
/// Parameters:
/// - `title`: The title of the movie.
/// - `description`: A brief overview or description of the movie.
/// - `genres`: Genres associated with the movie (e.g., action, comedy, drama, etc.).
/// - `releaseYear`: The year the movie was released.
class MovieDetails extends Equatable {
  final String title;
  final String description;
  final List<Genre> genres;
  final int releaseYear;

  /// Constructor for `MovieDetails`.
  const MovieDetails({
    required this.title,
    required this.description,
    required this.genres,
    required this.releaseYear,
  });

  @override
  List<Object?> get props => [title, description, genres, releaseYear];

  @override
  String toString() =>
      'MovieDetails(title: $title, description: $description, genres: $genres, releaseYear: $releaseYear)';

  /// Returns a copy of this `MovieDetails` but with the given fields replaced with new values.
  MovieDetails copyWith({
    String? title,
    String? description,
    List<Genre>? genres,
    int? releaseYear,
  }) {
    return MovieDetails(
      title: title ?? this.title,
      description: description ?? this.description,
      genres: genres ?? this.genres,
      releaseYear: releaseYear ?? this.releaseYear,
    );
  }
}
