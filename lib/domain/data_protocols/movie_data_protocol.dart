import 'package:either_dart/either.dart';

import '../entities/credits.dart';
import '../entities/genre.dart';
import '../entities/movie_details.dart';
import '../entities/movie_thumbnail.dart';
import '../entities/trailer.dart';

abstract class MovieProtocolError {
  final Object error;
  final Object? stackTrace;

  const MovieProtocolError(
    this.error, {
    this.stackTrace,
  });
}

/// Protocol for data repositories that will provide data relative to movies.
abstract class MovieDataProtocol {
  Future<Either<MovieProtocolError, List<MovieThumbnail>>> getMovieThumbnails({
    required Genre forGenre,
  });

  Future<Either<MovieProtocolError, List<Genre>>> getAllGenres({
    GenreType? forType,
  });

  Future<Either<MovieProtocolError, MovieDetails>> getMovieDetails({
    required int forMovieId,
  });

  Future<Either<MovieProtocolError, Credits>> getMovieCredits({
    required int forMovieId,
  });

  Future<Either<MovieProtocolError, List<Trailer>>> getMovieTrailers({
    required int forMovieId,
  });
}
