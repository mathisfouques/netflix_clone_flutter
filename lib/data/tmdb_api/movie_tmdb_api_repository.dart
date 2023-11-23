import 'package:either_dart/either.dart';
import 'package:dio/dio.dart';

import '../../domain/data_protocols/movie_data_protocol.dart';
import '../../domain/entities/genre.dart';
import '../../domain/entities/movie_details.dart';
import '../../domain/entities/movie_thumbnail.dart';
import '../../list_extension.dart';
import 'data_source/tmdb_api_data_source.dart';
import 'dto/movie_list/movie_list_dto.dart';
import 'dto/movie_list/movie_result_dto.dart';

enum MovieTmdbApiErrorType { remote, emptyResults, cantRetrieveGenres }

class MovieTmdbApiError implements MovieProtocolError {
  final Object error;
  final MovieTmdbApiErrorType type;
  final Object? stackTrace;
  final DioExceptionType? dioType;

  const MovieTmdbApiError(
    this.error,
    this.type, {
    this.stackTrace,
    this.dioType,
  });

  @override
  String toString() =>
      "Error on TmdbApi : '$error' of type ${error.runtimeType}.\nCause: $stackTrace";
}

class MovieTmdbApiRepository implements MovieDataProtocol {
  final TmdbApiDataSource _dataSource;

  MovieTmdbApiRepository({
    required TmdbApiDataSource dataSource,
  }) : _dataSource = dataSource;

  final _imageBaseUrl = "https://image.tmdb.org/t/p/";
  final _posterDefaultSize = "w185";

  // Question : Is it a good idea to have this here ?
  final Set<Genre> allGenres = {};

  Future<Either<MovieTmdbApiError, T>> safe<T>(Future<T> request) async {
    try {
      return Right(await request);
    } on DioException catch (e, stacktrace) {
      return Left(MovieTmdbApiError(
        e,
        MovieTmdbApiErrorType.remote,
        stackTrace: stacktrace,
        dioType: e.type,
      ));
    } catch (e, stacktrace) {
      return Left(MovieTmdbApiError(
        e,
        MovieTmdbApiErrorType.remote,
        stackTrace: stacktrace,
      ));
    }
  }

  @override
  Future<Either<MovieProtocolError, List<MovieThumbnail>>> getMovieThumbnails({
    required Genre forGenre,
  }) async {
    if (allGenres.isEmpty) {
      final genresRes = await getAllGenres();
      if (genresRes.isLeft) {
        return Left(MovieTmdbApiError(
          genresRes.left,
          MovieTmdbApiErrorType.cantRetrieveGenres,
          dioType: (genresRes.left as MovieTmdbApiError).dioType,
        ));
      }
    }

    final result = <MovieThumbnail>[];

    final Either<MovieTmdbApiError, MovieListDto> response = await safe(
      _dataSource.getMovieList(
        pageNumber: 1,
        withGenres: forGenre.id.toString(),
      ),
    );
    if (response.isLeft) return Left(response.left);

    final MovieListDto movieListDto = response.right;

    if (movieListDto.results.isEmpty) {
      return const Left(MovieTmdbApiError(
        "Results from request are empty",
        MovieTmdbApiErrorType.emptyResults,
      ));
    }

    for (MovieResultDto movieDto in movieListDto.results) {
      // Question : Does this check belong to the repository.
      // => If we remove it, the later used .firstWhere can return null.
      if (movieDto.genreIds.doesNotContain(forGenre.id)) {
        continue;
      }

      result.add(MovieThumbnail(
        isAdult: movieDto.adult,
        tmdbId: movieDto.id,
        genres: movieDto.genreIds.mapToList(
            (id) => allGenres.firstWhere((element) => element.id == id)),
        portraitSourceImage:
            _imageBaseUrl + _posterDefaultSize + movieDto.posterPath,
      ));
    }

    if (result.isEmpty) {
      return const Left(MovieTmdbApiError(
        "List of MovieThumbnail results are empty. Might be a mismatch of genreIds",
        MovieTmdbApiErrorType.emptyResults,
      ));
    }

    return Right(result);
  }

  @override
  Future<Either<MovieProtocolError, List<Genre>>> getAllGenres(
      {GenreType? forType}) async {
    final genres = <Genre>[];

    if (forType == GenreType.movie || forType == null) {
      final moviesGenres = await safe(_dataSource.getGenreMovieList());
      if (moviesGenres.isLeft) {
        return Left(MovieTmdbApiError(
          "Movie genres request failed",
          MovieTmdbApiErrorType.remote,
          dioType: moviesGenres.left.dioType,
        ));
      }

      genres.addAll(moviesGenres.right.genres.mapToList(
          (dto) => Genre(id: dto.id, type: GenreType.movie, title: dto.name)));
    }
    if (forType == GenreType.tvShow || forType == null) {
      final tvGenres = await safe(_dataSource.getGenreMovieList());
      if (tvGenres.isLeft) {
        return Left(MovieTmdbApiError(
          "Movie genres request failed",
          MovieTmdbApiErrorType.remote,
          dioType: tvGenres.left.dioType,
        ));
      }

      genres.addAll(tvGenres.right.genres.mapToList(
          (dto) => Genre(id: dto.id, type: GenreType.tvShow, title: dto.name)));
    }
    if (forType == null) allGenres.addAll(genres);

    return Right(genres);
  }

  Future<Either<MovieProtocolError, MovieDetails>> getMovieDetails({
    required int forMovieId,
  }) async {
    final movieDetails = await safe(
      _dataSource.getMovieDetails(movieId: forMovieId),
    );
    if (movieDetails.isLeft) {
      print(movieDetails.left.error.toString() +
          movieDetails.left.stackTrace.toString());

      return Left(MovieTmdbApiError(
        movieDetails.left.error,
        MovieTmdbApiErrorType.remote,
      ));
    }

    final dto = movieDetails.right;

    return Right(MovieDetails(
      title: dto.title,
      description: dto.overview,
      genres: dto.genres.mapToList((genreDto) =>
          Genre(id: genreDto.id, type: GenreType.movie, title: genreDto.name)),
      releaseYear: dto.releaseDate.year,
    ));
  }
}
