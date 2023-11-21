import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:netflix_clone/data/tmdb_api/dto/movie_list_dto.dart';
import 'package:netflix_clone/data/tmdb_api/movie_tmdb_api_repository.dart';
import 'package:netflix_clone/domain/entities/category_movies.dart';
import 'package:netflix_clone/domain/entities/genre.dart';
import 'package:netflix_clone/domain/entities/movie_thumbnail.dart';
import 'package:netflix_clone/domain/use_case/get_category_movies.dart';
import 'package:netflix_clone/list_extension.dart';
import 'package:netflix_clone/presentation/cubit/home_cubit.dart';

import 'mock/api_results/get_movie_list/get_movie_list_with_genre_12.dart';
import 'mock/api_results/get_movie_list/get_movie_list_with_genre_28.dart';
import 'mock/api_results/get_movie_list/get_movie_list_with_genre_36.dart';
import 'mock/api_results/get_movie_list/get_movie_list_with_genre_37.dart';
import 'mock/api_results/get_movie_list/get_movie_list_with_genre_53.dart';
import 'mock/mock_tmdb_api_data_source.dart';
import 'movie_tmdb_api_repository_test.dart';

Map<String, dynamic> correctApiResultForGenreId(int id) {
  switch (id) {
    case 28:
      return mockGetMovieListWithGenre28;
    case 53:
      return mockGetMovieListWithGenre53;
    case 12:
      return mockGetMovieListWithGenre12;
    case 37:
      return mockGetMovieListWithGenre37;
    case 36:
      return mockGetMovieListWithGenre36;
    default:
      return {};
  }
}

void main() {
  group("[HOME CUBIT]", () {
    final genresThatHaveAnApiResultMocked = <Genre>[
      const Genre(id: 28, type: GenreType.movie, title: "?"),
      const Genre(id: 53, type: GenreType.movie, title: "?"),
      const Genre(id: 12, type: GenreType.movie, title: "?"),
      const Genre(id: 37, type: GenreType.movie, title: "?"),
      const Genre(id: 36, type: GenreType.movie, title: "?"),
    ];

    final categoryMoviesOfGenresThatHaveApiResultMocked =
        genresThatHaveAnApiResultMocked.mapToList<CategoryMovies>((genre) {
      final correctApiResult = correctApiResultForGenreId(genre.id);
      final correctDto = MovieListDto.fromJson(correctApiResult);
      final movieThumbnails =
          correctDto.results.mapToList((dto) => MovieThumbnail(
                isAdult: false,
                tmdbId: dto.id,
                genres: [genre],
                portraitSourceImage: dto.posterPath,
              ));
      return CategoryMovies(
          isAdult: false, movies: movieThumbnails, genre: genre);
    });

    blocTest<HomeCubit, HomeState>(
      'emits [Loading,Success] when fetchMovies is called.',
      build: () => HomeCubit(
        movieRepo: MovieTmdbApiRepository(
          dataSource: const MockTmdbApiDataSource(),
        ),
      ),
      act: (cubit) =>
          cubit.fetchMovies(forGenres: genresThatHaveAnApiResultMocked),
      expect: () => <HomeState>[
        LoadingHomeFetchMovies(),
        SuccessHomeFetchMovies(
            categories: categoryMoviesOfGenresThatHaveApiResultMocked)
      ],
    );

    blocTest<HomeCubit, HomeState>(
      'emits [Loading,Failure] when fetchMovies is called.',
      build: () => HomeCubit(
        movieRepo: MovieTmdbApiRepository(
          dataSource: const MockTmdbApiDataSource(),
        ),
      ),
      act: (cubit) => cubit.fetchMovies(numberOfCategories: 100),
      expect: () => <HomeState>[
        LoadingHomeFetchMovies(),
        const FailureHomeFetchMovies(GetCategoryMoviesUseCaseError(
          "",
          CategoryMoviesErrorType.tooMuchCategories,
        ))
      ],
    );

    blocTest<HomeCubit, HomeState>(
      'emits [MyState] when fetchMovies is called.',
      build: () => HomeCubit(
        movieRepo: MovieTmdbApiRepository(
          dataSource: MockTmdbApiDataSource(
              allGenresFailsWith: CustomDioException.badResponse()),
        ),
      ),
      act: (cubit) => cubit.fetchMovies(),
      expect: () => <HomeState>[
        LoadingHomeFetchMovies(),
        const FailureHomeFetchMovies(GetCategoryMoviesUseCaseError(
          "",
          CategoryMoviesErrorType.failingFetchingGenres,
        ))
      ],
    );

    blocTest<HomeCubit, HomeState>(
      'Given a repo that fails fetching movies emits [Loading,Failure] when fetchMovies is called.',
      build: () => HomeCubit(
        movieRepo: MovieTmdbApiRepository(
          dataSource: MockTmdbApiDataSource(
              dioException: CustomDioException.badResponse()),
        ),
      ),
      act: (cubit) => cubit.fetchMovies(),
      expect: () => <HomeState>[
        LoadingHomeFetchMovies(),
        const FailureHomeFetchMovies(GetCategoryMoviesUseCaseError(
          "",
          CategoryMoviesErrorType.failingFetchingMovies,
        ))
      ],
    );
  });
}
