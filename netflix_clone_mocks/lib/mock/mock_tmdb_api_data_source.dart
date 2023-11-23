import 'package:dio/dio.dart';

import 'package:netflix_clone/data/tmdb_api/data_source/tmdb_api_data_source.dart';
import 'package:netflix_clone/data/tmdb_api/dto/genre/genre_list_dto.dart';
import 'package:netflix_clone/data/tmdb_api/dto/movie_details/movie_details_dto.dart';
import 'package:netflix_clone/data/tmdb_api/dto/movie_list/movie_list_dto.dart';

import 'package:netflix_clone/domain/entities/genre.dart';
import 'package:netflix_clone_mocks/mock/api_results/movie_details/get_movie_details_for_movie_670292.dart';

import 'api_results/get_genre_movie_list.dart';
import 'api_results/get_genre_tv_list.dart';
import 'api_results/get_movie_list/get_movie_list_with_empty_results.dart';
import 'api_results/get_movie_list/get_movie_list_with_genre_12.dart';
import 'api_results/get_movie_list/get_movie_list_with_genre_28.dart';
import 'api_results/get_movie_list/get_movie_list_with_genre_36.dart';
import 'api_results/get_movie_list/get_movie_list_with_genre_37.dart';
import 'api_results/get_movie_list/get_movie_list_with_genre_53.dart';

class MockTmdbApiDataSource implements TmdbApiDataSource {
  final DioException? dioException;
  final bool movieResultsWithIncorrectGenreIds;
  final bool movieEmptyResults;
  final DioException? allGenresFailsWith;

  const MockTmdbApiDataSource({
    this.dioException,
    this.movieResultsWithIncorrectGenreIds = false,
    this.movieEmptyResults = false,
    this.allGenresFailsWith,
  });

  static get genresThatHaveAnApiResultMocked => <Genre>[
        const Genre(id: 28, type: GenreType.movie, title: "Action"),
        const Genre(id: 53, type: GenreType.movie, title: "Thriller"),
        const Genre(id: 12, type: GenreType.movie, title: "Adventure"),
        const Genre(id: 37, type: GenreType.movie, title: "Western"),
        const Genre(id: 36, type: GenreType.movie, title: "History"),
      ];

  @override
  Future<GenreListDto> getGenreMovieList() async {
    if (allGenresFailsWith != null) throw allGenresFailsWith!;

    final GenreListDto dto = GenreListDto.fromJson(mockGetGenreMovieList);

    return dto;
  }

  @override
  Future<GenreListDto> getGenreTvList() async {
    if (allGenresFailsWith != null) throw allGenresFailsWith!;

    final GenreListDto dto = GenreListDto.fromJson(mockGetGenreTvList);

    return dto;
  }

  @override
  Future<MovieListDto> getMovieList({
    required int pageNumber,
    required String withGenres,
  }) async {
    if (dioException != null) {
      throw dioException!;
    }

    if (withGenres == "37" && movieResultsWithIncorrectGenreIds) {
      return MovieListDto.fromJson(mockGetMovieListWithGenre12);
    }
    if (movieEmptyResults) {
      return MovieListDto.fromJson(mockGetMovieListWithEmptyResults);
    }

    if (withGenres == "28") {
      return MovieListDto.fromJson(mockGetMovieListWithGenre28);
    } else if (withGenres == "53") {
      return MovieListDto.fromJson(mockGetMovieListWithGenre53);
    } else if (withGenres == "12") {
      return MovieListDto.fromJson(mockGetMovieListWithGenre12);
    } else if (withGenres == "37") {
      return MovieListDto.fromJson(mockGetMovieListWithGenre37);
    } else if (withGenres == "36") {
      return MovieListDto.fromJson(mockGetMovieListWithGenre36);
    }
    throw UnimplementedError();
  }

  @override
  Future<MovieListDto> getPopularMovieList({required int pageNumber}) {
    // TODO: implement getPopularMovieList
    throw UnimplementedError();
  }

  @override
  Future<MovieDetailsDto> getMovieDetails({int movieId = 670292}) async {
    if (movieId == 670292) {
      return MovieDetailsDto.fromJson(getMovieDetailsForMovie670292);
    }
    throw UnimplementedError();
  }
}
