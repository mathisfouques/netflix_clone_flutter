import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

import '../dto/genre/genre_list_dto.dart';
import '../dto/movie_details/movie_details_dto.dart';
import '../dto/movie_list/movie_list_dto.dart';

part 'tmdb_api_data_source.g.dart';

@RestApi(baseUrl: "https://api.themoviedb.org/3")
abstract class TmdbApiDataSource {
  factory TmdbApiDataSource(Dio dio, {String baseUrl}) = _TmdbApiDataSource;

  /// On with_genres, tmdb uses comma ( , ) for AND , pipe ( | ) for OR
  /// Can use ids instead of full string for genres.
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

  @GET("/movie/{movie_id}")
  Future<MovieDetailsDto> getMovieDetails({
    @Path('movie_id') int movieId = 670292,
  });
}
