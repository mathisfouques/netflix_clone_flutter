import 'package:dio/dio.dart';

import '../../domain/data_protocols/movie_data_protocol.dart';
import '../../domain/entities/genre.dart';
import '../../domain/entities/movie_thumbnail.dart';
import '../../list_extension.dart';
import 'data_source/tmdb_api_data_source.dart';
import 'dto/movie_list_dto.dart';
import 'dto/movie_result_dto.dart';
import 'tmdb_custom_dio.dart';

class MovieTmdbApiRepository implements MovieDataProtocol {
  final TmdbApiDataSource _dataSource = TmdbApiDataSource(TmdbCustomDio().dio);
  final _imageBaseUrl = "https://image.tmdb.org/t/p/";
  final _posterDefaultSize = "w185";

  final List<Genre> allGenres = [];

  @override
  Future<List<MovieThumbnail>> getMovieThumbnails({
    required Genre forGenre,
  }) async {
    if (allGenres.isEmpty) {
      await getAllGenres();
    }

    final result = <MovieThumbnail>[];

    final MovieListDto movieListDto = await _dataSource
        .getMovieList(pageNumber: 1, withGenres: forGenre.id.toString())
        .catchError(
      (obj) {
        switch (obj.runtimeType) {
          case DioException:
            final res = (obj as DioException).response;
            print(res?.data.toString());
            break;
          default:
            print("From Repository implementation tmdbApi : ${obj.toString()}");
            break;
        }

        return MovieListDto(
          page: 0,
          results: [],
          totalPages: 1,
          totalResults: 1,
        );
      },
    );

    if (movieListDto.results.isEmpty) {
      print("For genre : ${forGenre.title}, there are no results...");
    }

    for (MovieResultDto movieDto in movieListDto.results) {
      if (movieDto.genreIds.doesNotContain(forGenre.id)) {
        print(
            "${movieDto.originalTitle} : ${forGenre.title} but not ${forGenre.title}");

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
      final moviesGenres = await _dataSource.getGenreMovieList();
      genres.addAll(moviesGenres.genres.mapToList(
          (dto) => Genre(id: dto.id, type: GenreType.movie, title: dto.name)));
    }
    if (forType == GenreType.tvShow || forType == null) {
      final tvGenres = await _dataSource.getGenreTvList();
      genres.addAll(tvGenres.genres.mapToList(
          (dto) => Genre(id: dto.id, type: GenreType.tvShow, title: dto.name)));
    }
    if (forType == null) allGenres.addAll(genres);

    return genres;
  }
}
