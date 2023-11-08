import 'package:equatable/equatable.dart';

import 'genre.dart';

/// Assemble information needed to display a thumbnail of the movie/Serie on the homepage.
class MovieThumbnail extends Equatable {
  /// Indicates whether the content is for adults.
  final bool isAdult;

  /// The ID of the movie on TMDb (The Movie Database).
  final int tmdbId;

  /// List of genres associated with the movie.
  final List<Genre> genres;

  /// The source URL for the portrait image of the movie.
  final String portraitSourceImage;

  const MovieThumbnail({
    required this.isAdult,
    required this.tmdbId,
    required this.genres,
    required this.portraitSourceImage,
  });

  @override
  List<Object?> get props => [isAdult, tmdbId, genres, portraitSourceImage];

  @override
  String toString() {
    return 'MovieThumbnail(isAdult: $isAdult, tmdbId: $tmdbId, genres: $genres, portraitSourceImage: $portraitSourceImage)';
  }

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
