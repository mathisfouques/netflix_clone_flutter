import 'package:either_dart/either.dart';

import '../entities/genre.dart';
import '../entities/movie_thumbnail.dart';

abstract class MovieProtocolError {}

/// Protocol for data repositories that will provide data relative to movies.
abstract class MovieDataProtocol {
  Future<Either<MovieProtocolError, List<MovieThumbnail>>> getMovieThumbnails({
    required Genre forGenre,
  });

  Future<Either<MovieProtocolError, List<Genre>>> getAllGenres({
    GenreType? forType,
  });
}
