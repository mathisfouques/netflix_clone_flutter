import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

import 'dto/movie_list_dto.dart';
import 'dto/genre_list_dto.dart';

part 'tmdb_api_service.g.dart';

@RestApi(baseUrl: "https://api.themoviedb.org/3")
abstract class TmdbApiService {
  factory TmdbApiService(Dio dio, {String baseUrl}) = _TmdbApiService;

  /// On with_genres, tmdb uses comma ( , ) for AND , pipe ( | ) for OR
  @GET('/discover/movie')
  Future<MovieListDto> getMovieList({
    @Query("page") required int pageNumber,
    @Query("with_genres") required String withGenres,
  });

  @GET("/movie/popular")
  Future<MovieListDto> getPopularMovieList({
    @Query("page") required int pageNumber,
  });

  @GET("/genre/tv/list")
  Future<GenreListDto> getGenreTvList();

  @GET("/genre/movie/list")
  Future<GenreListDto> getGenreMovieList();
}
