import 'package:netflix_clone/data/tmdb_api/dto/genre_list_dto.dart';

import '../../domain/data_protocols/movie_data_protocol.dart';
import '../../domain/entities/genre.dart';
import '../../domain/entities/movie_thumbnail.dart';
import '../../list_extension.dart';
import 'data_source/tmdb_api_data_source.dart';
import 'dto/movie_list_dto.dart';
import 'dto/movie_result_dto.dart';

class MovieTmdbApiRepository implements MovieDataProtocol {
  final TmdbApiDataSource _dataSource;

  MovieTmdbApiRepository({
    required TmdbApiDataSource dataSource,
  }) : _dataSource = dataSource;

  final _imageBaseUrl = "https://image.tmdb.org/t/p/";
  final _posterDefaultSize = "w185";

  // Question : Is it a good idea to have this here ?
  final Set<Genre> allGenres = {};

  @override
  Future<List<MovieThumbnail>> getMovieThumbnails({
    required Genre forGenre,
  }) async {
    if (allGenres.isEmpty) {
      await getAllGenres();
    }

    final result = <MovieThumbnail>[];
    final MovieListDto movieListDto = await _dataSource.getMovieList(
      pageNumber: 1,
      withGenres: forGenre.id.toString(),
    );

    // Question : Does this check belong to repository
    if (movieListDto.results.isEmpty) {
      print("For genre : ${forGenre.title}, there are no results...");
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

    return result;
  }

  @override
  Future<List<Genre>> getAllGenres({GenreType? forType}) async {
    final genres = <Genre>[];

    if (forType == GenreType.movie || forType == null) {
      final moviesGenres =
          await _dataSource.getGenreMovieList().catchError(onErrorGetAllGenres);
      genres.addAll(moviesGenres.genres.mapToList(
          (dto) => Genre(id: dto.id, type: GenreType.movie, title: dto.name)));
    }
    if (forType == GenreType.tvShow || forType == null) {
      final tvGenres =
          await _dataSource.getGenreTvList().catchError(onErrorGetAllGenres);
      genres.addAll(tvGenres.genres.mapToList(
          (dto) => Genre(id: dto.id, type: GenreType.tvShow, title: dto.name)));
    }
    if (forType == null) allGenres.addAll(genres);

    return genres;
  }

  Future<GenreListDto> onErrorGetAllGenres(Object? error) async {
    print(error?.runtimeType);
    print(error?.toString());

    return GenreListDto(genres: []);
  }
}
