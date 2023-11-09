import '../entities/genre.dart';
import '../entities/movie_thumbnail.dart';

/// Protocol for data repositories that will provide data relative to movies.
abstract class MovieDataProtocol {
  Future<List<MovieThumbnail>> getMovieThumbnails({required Genre forGenre});

  Future<List<Genre>> getAllGenres({GenreType? forType});
}
