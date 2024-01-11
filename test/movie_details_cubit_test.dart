import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:netflix_clone/data/tmdb_api/movie_tmdb_api_repository.dart';
import 'package:netflix_clone/domain/use_case/get_movie_details.dart';

import 'package:netflix_clone/presentation/movie_details/movie_details_cubit.dart';
import 'package:netflix_clone_mocks/netflix_clone_mocks.dart';

import 'movie_tmdb_api_repository_test.dart';

void main() {
  final correctId = MockedValuesForTmdbApiRepository.correctMovieId;
  final correctMovieDetails =
      MockedValuesForTmdbApiRepository.correctMovieDetails;

  group("[MOVIE_DETAILS_CUBIT]", () {
    blocTest<MovieDetailsCubit, MovieDetailsState>(
      'Given a working repo emits [Loading,Success] (with every information on moviedetails) when fetchMovieDetails is called.',
      build: () => MovieDetailsCubit(
          movieRepo: MovieTmdbApiRepository(
              dataSource: const MockTmdbApiDataSource())),
      act: (cubit) => cubit.fetchMovieDetails(forMovieId: correctId),
      expect: () => <MovieDetailsState>[
        LoadingMovieDetails(),
        SuccessMovieDetails(
            movieDetails: correctMovieDetails
              ..copyWith(
                credits: MockedValuesForTmdbApiRepository.correctCredits,
                trailers: MockedValuesForTmdbApiRepository.correctTrailers,
                similarMovies:
                    MockedValuesForTmdbApiRepository.correctSimilarMovies,
              ))
      ],
    );

    blocTest<MovieDetailsCubit, MovieDetailsState>(
      'Given a failing repo for credits emits [Loading,Success] (with every information on moviedetails, EXCEPT Credits) when fetchMovieDetails is called.',
      build: () => MovieDetailsCubit(
          movieRepo: MovieTmdbApiRepository(
              dataSource: MockTmdbApiDataSource(
                  movieCreditsFailsWith: CustomDioException.badResponse()))),
      act: (cubit) => cubit.fetchMovieDetails(forMovieId: correctId),
      expect: () => <MovieDetailsState>[
        LoadingMovieDetails(),
        SuccessMovieDetails(
            movieDetails: correctMovieDetails
              ..copyWith(
                trailers: MockedValuesForTmdbApiRepository.correctTrailers,
                similarMovies:
                    MockedValuesForTmdbApiRepository.correctSimilarMovies,
              ))
      ],
    );

    blocTest<MovieDetailsCubit, MovieDetailsState>(
      'Given a failing repo for trailers emits [Loading,Success] (with every information on moviedetails, EXCEPT Trailers) when fetchMovieDetails is called.',
      build: () => MovieDetailsCubit(
          movieRepo: MovieTmdbApiRepository(
              dataSource: MockTmdbApiDataSource(
                  movieVideosFailsWith: CustomDioException.badResponse()))),
      act: (cubit) => cubit.fetchMovieDetails(forMovieId: correctId),
      expect: () => <MovieDetailsState>[
        LoadingMovieDetails(),
        SuccessMovieDetails(
            movieDetails: correctMovieDetails
              ..copyWith(
                credits: MockedValuesForTmdbApiRepository.correctCredits,
                similarMovies:
                    MockedValuesForTmdbApiRepository.correctSimilarMovies,
              ))
      ],
    );

    blocTest<MovieDetailsCubit, MovieDetailsState>(
      'Given a failing repo for similar movies emits [Loading,Success] (with every information on moviedetails, EXCEPT Similar movies) when fetchMovieDetails is called.',
      build: () => MovieDetailsCubit(
          movieRepo: MovieTmdbApiRepository(
              dataSource: MockTmdbApiDataSource(
                  similarMoviesFailsWith: CustomDioException.badResponse()))),
      act: (cubit) => cubit.fetchMovieDetails(forMovieId: correctId),
      expect: () => <MovieDetailsState>[
        LoadingMovieDetails(),
        SuccessMovieDetails(
            movieDetails: correctMovieDetails
              ..copyWith(
                credits: MockedValuesForTmdbApiRepository.correctCredits,
                trailers: MockedValuesForTmdbApiRepository.correctTrailers,
              ))
      ],
    );

    blocTest<MovieDetailsCubit, MovieDetailsState>(
      'Given a failing repo on movie details (bad response) emits [Loading,Failing] w/ failure with bad response when fetchMovieDetails is called.',
      build: () => MovieDetailsCubit(
          movieRepo: MovieTmdbApiRepository(
              dataSource: MockTmdbApiDataSource(
                  movieDetailsFailsWith: CustomDioException.badResponse()))),
      act: (cubit) => cubit.fetchMovieDetails(forMovieId: correctId),
      expect: () => <MovieDetailsState>[
        LoadingMovieDetails(),
        const FailureMovieDetails(
            error: GetMovieDetailsError(
                error: "",
                type: GetMovieDetailsErrorType.failingFetchingDetails)),
      ],
    );

    blocTest<MovieDetailsCubit, MovieDetailsState>(
      'Given a working repo BUT an id missmatch emits [Loading, Failure] when fetchMovieDetails is called.',
      build: () => MovieDetailsCubit(
          movieRepo: MovieTmdbApiRepository(
              dataSource: const MockTmdbApiDataSource(
        movieDetailsWithIdMissmatch: true,
      ))),
      act: (cubit) => cubit.fetchMovieDetails(forMovieId: 3),
      expect: () => <MovieDetailsState>[
        LoadingMovieDetails(),
        const FailureMovieDetails(
            error: GetMovieDetailsError(
          error: "error",
          type: GetMovieDetailsErrorType.idMissmatch,
        ))
      ],
    );

    blocTest<MovieDetailsCubit, MovieDetailsState>(
      'Given a bloc in a success movie state emits [Success] when dismiss is called.',
      build: () => MovieDetailsCubit(
          movieRepo: MovieTmdbApiRepository(
              dataSource: const MockTmdbApiDataSource())),
      seed: () => SuccessMovieDetails(movieDetails: correctMovieDetails),
      act: (cubit) => cubit.dismiss(),
      expect: () => <MovieDetailsState>[
        SuccessMovieDetails(
          movieDetails: correctMovieDetails
            ..copyWith(
              credits: MockedValuesForTmdbApiRepository.correctCredits,
              trailers: MockedValuesForTmdbApiRepository.correctTrailers,
              similarMovies:
                  MockedValuesForTmdbApiRepository.correctSimilarMovies,
            ),
          isDismissed: true,
        ),
      ],
    );
  });
}
