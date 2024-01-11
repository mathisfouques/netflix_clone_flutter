import 'package:equatable/equatable.dart';

import 'credits.dart';
import 'genre.dart';
import 'movie_thumbnail.dart';
import 'trailer.dart';

/// Assemble all information about one movie: date, realization, description, etc.
///
/// Parameters:
/// - `title`: The title of the movie.
/// - `description`: A brief overview or description of the movie.
/// - `genres`: Genres associated with the movie (e.g., action, comedy, drama, etc.).
/// - `releaseYear`: The year the movie was released.
/// - `id`: Id of the movie.
/// - `credits`: The credits of the movie. Can be null if the credits call didn't work as expected.
/// - `trailers`: The list of movie videos of type Trailer and coming from YouTube. Can be null.
/// - `similarMovies`: A list of MovieThumbnails that are similar to the movie. Can be null.
class MovieDetails extends Equatable {
  final String title;
  final String description;
  final List<Genre> genres;
  final int? releaseYear;
  final MovieDuration duration;
  final int id;
  final Credits? credits;
  final List<Trailer>? trailers;
  final List<MovieThumbnail>? similarMovies;

  /// Constructor for `MovieDetails`.
  const MovieDetails({
    required this.title,
    required this.description,
    required this.genres,
    this.releaseYear,
    required this.duration,
    required this.id,
    this.credits,
    this.trailers,
    this.similarMovies,
  });

  @override
  List<Object?> get props => [
        title,
        description,
        genres,
        releaseYear,
        duration,
        id,
        credits,
        trailers,
        similarMovies
      ];

  @override
  String toString() =>
      'MovieDetails(title: $title, description: $description, genres: $genres, releaseYear: $releaseYear, id: $id, credits: $credits, trailers: $trailers, similarMovies: $similarMovies)';

  /// Returns a copy of this `MovieDetails` but with the given fields replaced with new values.
  MovieDetails copyWith({
    String? title,
    String? description,
    List<Genre>? genres,
    int? releaseYear,
    MovieDuration? duration,
    int? id,
    Credits? credits,
    List<Trailer>? trailers,
    List<MovieThumbnail>? similarMovies,
  }) {
    return MovieDetails(
      title: title ?? this.title,
      description: description ?? this.description,
      genres: genres ?? this.genres,
      releaseYear: releaseYear ?? this.releaseYear,
      duration: duration ?? this.duration,
      id: id ?? this.id,
      credits: credits ?? this.credits,
      trailers: trailers ?? this.trailers,
      similarMovies: similarMovies ?? this.similarMovies,
    );
  }
}

class MovieDuration {
  final int rawMinuteDuration;
  final String representation;

  MovieDuration(this.rawMinuteDuration, this.representation);

  factory MovieDuration.fromMinutes(int minutes) {
    final rep = "${minutes ~/ 60}h ${minutes % 60}m";

    return MovieDuration(minutes, rep);
  }
}
