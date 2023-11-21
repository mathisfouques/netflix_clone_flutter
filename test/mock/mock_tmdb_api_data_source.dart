import 'package:netflix_clone/data/tmdb_api/data_source/tmdb_api_data_source.dart';
import 'package:netflix_clone/data/tmdb_api/dto/genre_list_dto.dart';
import 'package:netflix_clone/data/tmdb_api/dto/movie_list_dto.dart';

class MockTmdbApiDataSource implements TmdbApiDataSource {
  @override
  Future<GenreListDto> getGenreMovieList() {
    // TODO: implement getGenreMovieList
    throw UnimplementedError();
  }

  @override
  Future<GenreListDto> getGenreTvList() {
    // TODO: implement getGenreTvList
    throw UnimplementedError();
  }

  @override
  Future<MovieListDto> getMovieList({
    required int pageNumber,
    required String withGenres,
  }) {
    // TODO: implement getMovieList
    throw UnimplementedError();
  }

  @override
  Future<MovieListDto> getPopularMovieList({required int pageNumber}) {
    // TODO: implement getPopularMovieList
    throw UnimplementedError();
  }
}
