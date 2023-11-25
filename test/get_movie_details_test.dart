import 'package:flutter_test/flutter_test.dart';
import 'package:netflix_clone/data/tmdb_api/movie_tmdb_api_repository.dart';
import 'package:netflix_clone/domain/use_case/get_movie_details.dart';
import 'package:netflix_clone_mocks/netflix_clone_mocks.dart';

import 'movie_tmdb_api_repository_test.dart';

void main() {
  group(
    "\n[GET_MOVIE_DETAILS]",
    () {
      test(
          'GIVEN a working repository, EXPECT succesfull return WHEN calling usecase.',
          () async {
        final repo =
            MovieTmdbApiRepository(dataSource: const MockTmdbApiDataSource());
        final usecase = GetMovieDetailsUseCase(
          movieId: MovieTmdbRepositoryMockedCorrectValues.correctMovieId,
          repo: repo,
        );

        final result = await usecase();

        expect(result.isRight, true);
        expect(
          result.right.description,
          MovieTmdbRepositoryMockedCorrectValues
              .correctMovieDetails.description,
        );
      });

      test(
        'GIVEN a failing (at details, remote) repo EXPECT an GetMovieDetailsError with failingFetchingDetails WHEN calling usecase.',
        () async {
          final repo = MovieTmdbApiRepository(
              dataSource: MockTmdbApiDataSource(
                  movieDetailsFailsWith: CustomDioException.badResponse()));
          late final usecase = GetMovieDetailsUseCase(
            movieId: MovieTmdbRepositoryMockedCorrectValues.correctMovieId,
            repo: repo,
          );

          final result = await usecase();

          expect(result.isLeft, true);
          expect(result.left.runtimeType, GetMovieDetailsError);
          expect(result.left.type,
              GetMovieDetailsErrorType.failingFetchingDetails);
        },
      );

      test(
          'GIVEN a working repository, but with an incorrect id EXPECT GetMovieDetailsError with type idMissmatch WHEN calling usecase.',
          () async {
        final repo =
            MovieTmdbApiRepository(dataSource: const MockTmdbApiDataSource());
        final usecase = GetMovieDetailsUseCase(
          movieId: 0,
          repo: repo,
        );

        final result = await usecase();

        expect(result.isLeft, true);
        expect(result.left.runtimeType, GetMovieDetailsError);
        expect(result.left.type, GetMovieDetailsErrorType.idMissmatch);
      });

      group("[CREDITS]", () {
        test(
          'GIVEN a working repo EXPECT the movie details to contain a non null credits, with correct credits WHEN calling usecase.',
          () async {
            final repo = MovieTmdbApiRepository(
                dataSource: const MockTmdbApiDataSource());
            final usecase = GetMovieDetailsUseCase(
              movieId: MovieTmdbRepositoryMockedCorrectValues.correctMovieId,
              repo: repo,
            );

            final result = await usecase();

            expect(result.isRight, true);
            expect(result.right.credits == null, false);
            expect(
              result.right.credits,
              MovieTmdbRepositoryMockedCorrectValues.correctCredits,
            );
          },
        );

        test(
          'GIVEN a failing repo for credits EXPECT a successfull return but with null value on credits WHEN calling usecase.',
          () async {
            final repo = MovieTmdbApiRepository(
                dataSource: MockTmdbApiDataSource(
                    movieCreditsFailsWith: CustomDioException.badResponse()));
            final usecase = GetMovieDetailsUseCase(
              movieId: MovieTmdbRepositoryMockedCorrectValues.correctMovieId,
              repo: repo,
            );

            final result = await usecase();

            expect(result.isRight, true);
            expect(result.right.credits, null);
          },
        );
      });

      group("[TRAILERS]", () {
        test(
          'GIVEN a working repo EXPECT the movie details to contain non null list of trailers WHEN calling usecase.',
          () async {
            final repo = MovieTmdbApiRepository(
                dataSource: const MockTmdbApiDataSource());
            final usecase = GetMovieDetailsUseCase(
              movieId: MovieTmdbRepositoryMockedCorrectValues.correctMovieId,
              repo: repo,
            );

            final result = await usecase();

            expect(result.isRight, true);
            expect(result.right.trailers != null, true);
            expect(result.right.trailers,
                MovieTmdbRepositoryMockedCorrectValues.correctTrailers);
          },
        );

        test(
          'GIVEN a failing repo for credits EXPECT a successfull return but with null value on credits WHEN calling usecase.',
          () async {
            final repo = MovieTmdbApiRepository(
                dataSource: MockTmdbApiDataSource(
                    movieVideosFailsWith: CustomDioException.badResponse()));
            final usecase = GetMovieDetailsUseCase(
              movieId: MovieTmdbRepositoryMockedCorrectValues.correctMovieId,
              repo: repo,
            );

            final result = await usecase();

            expect(result.isRight, true);
            expect(result.right.trailers, null);
          },
        );
      });
    },
  );
}
