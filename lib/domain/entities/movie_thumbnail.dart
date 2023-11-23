import 'package:equatable/equatable.dart';

import 'genre.dart';

/// Assemble informations needed to display a thumbnail of the movie/Serie on the homepage.
///
/// Parameters:
/// - `isAdult`: Indicates if the movie is for adults.
/// - `tmdbId`: The movie's ID from TMDB.
/// - `genres`: A list of genres the movie belongs to.
/// - `portraitSourceImage`: The source URL for the movie's portrait image.
class MovieThumbnail extends Equatable {
  final bool isAdult;
  final int tmdbId;
  final List<Genre> genres;
  final String portraitSourceImage;

  /// Constructor for `MovieThumbnail`.
  const MovieThumbnail({
    required this.isAdult,
    required this.tmdbId,
    required this.genres,
    required this.portraitSourceImage,
  });

  @override
  List<Object?> get props => [isAdult, tmdbId, genres, portraitSourceImage];

  @override
  String toString() =>
      'MovieThumbnail(isAdult: $isAdult, tmdbId: $tmdbId, genres: $genres, portraitSourceImage: $portraitSourceImage)';

  /// Returns a copy of this `MovieThumbnail` but with the given fields replaced with new values.
  MovieThumbnail copyWith({
    bool? isAdult,
    int? tmdbId,
    List<Genre>? genres,
    String? portraitSourceImage,
  }) {
    return MovieThumbnail(
      isAdult: isAdult ?? this.isAdult,
      tmdbId: tmdbId ?? this.tmdbId,
      genres: genres ?? this.genres,
      portraitSourceImage: portraitSourceImage ?? this.portraitSourceImage,
    );
  }
}
