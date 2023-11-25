import 'package:equatable/equatable.dart';

/// Encapsulates the director of the movie, as well as a few of the most popular actors that played in the movie.
///
/// Parameters:
/// - `forMovieId`: Id of the movie associated with the credits.
/// - `director`: The director of a movie.
/// - `popularActors`: Most popular actors playing in the movie, by name.
class Credits extends Equatable {
  final int forMovieId;
  final String director;
  final List<String> popularActors;

  /// Constructor for `Credits`.
  const Credits({
    required this.forMovieId,
    required this.director,
    required this.popularActors,
  });

  @override
  List<Object?> get props => [forMovieId, director, popularActors];

  @override
  String toString() =>
      'Credits(forMovieId: $forMovieId, director: $director, popularActors: $popularActors)';

  /// Returns a copy of this `Credits` but with the given fields replaced with new values.
  Credits copyWith({
    int? forMovieId,
    String? director,
    List<String>? popularActors,
  }) {
    return Credits(
      forMovieId: forMovieId ?? this.forMovieId,
      director: director ?? this.director,
      popularActors: popularActors ?? this.popularActors,
    );
  }
}
