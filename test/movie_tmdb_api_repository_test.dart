
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:netflix_clone/data/tmdb_api/movie_tmdb_api_repository.dart';
import 'package:netflix_clone/domain/entities/genre.dart';

import 'mock/mock_tmdb_api_data_source.dart';

extension CustomDioException on DioException {
  static badResponse() => DioException.badResponse(
      statusCode: 404,
      requestOptions: RequestOptions(),
      response: Response(requestOptions: RequestOptions()));
  static connectionTimeout() => DioException.connectionTimeout(
      requestOptions: RequestOptions(), timeout: const Duration(seconds: 1));
}

void main() {
  const dataSourceAllWorking = MockTmdbApiDataSource();
  group("\n[MOVIE_TMDB_API_REPO]", () {
    group('[GENRES]\n', () {
      test(
        "Expect the repositories to retrieve allGenres \nWHEN getAllGenres is called",
        () async {
          final repo = MovieTmdbApiRepository(dataSource: dataSourceAllWorking);

          final allGenres = await repo.getAllGenres();

          expect(repo.allGenres, isNotEmpty);
          expect(allGenres.isRight, true);
          expect(
            allGenres.right.where((element) => element.type == GenreType.movie),
            isNotEmpty,
          );
          expect(
            allGenres.right
                .where((element) => element.type == GenreType.tvShow),
            isNotEmpty,
          );
        },
      );

      test(
        "Expect the repositories allGenres List to be empty AND retrieve only movie genres \nWHEN getAllGenres is called With specific genre type Movie",
        () async {
          final repo = MovieTmdbApiRepository(dataSource: dataSourceAllWorking);
          final genresWithTypeMovie =
              await repo.getAllGenres(forType: GenreType.movie);

          expect(repo.allGenres, isEmpty);
          expect(genresWithTypeMovie.isRight, true);

          expect(
            genresWithTypeMovie.right
                .where((element) => element.type == GenreType.tvShow),
            isEmpty,
          );
        },
      );

      test(
        "Expect the repositories allGenres List to be empty AND retrieve only tvShow genres \nWHEN getAllGenres is called With specific genre type TvShow",
        () async {
          final repo = MovieTmdbApiRepository(dataSource: dataSourceAllWorking);
          final genresWithTypeTvShow =
              await repo.getAllGenres(forType: GenreType.tvShow);

          expect(repo.allGenres, isEmpty);
          expect(genresWithTypeTvShow.isRight, true);
          expect(
            genresWithTypeTvShow.right
                .where((element) => element.type == GenreType.movie),
            isEmpty,
          );
        },
      );

      test(
        'GIVEN a data source with genres failing with timeout EXPECT WHEN calling getAllGenres.',
        () async {
          final repo = MovieTmdbApiRepository(
              dataSource: MockTmdbApiDataSource(
                  allGenresFailsWith: CustomDioException.connectionTimeout()));
          final allGenres = await repo.getAllGenres();

          expect(repo.allGenres, isEmpty);
          expect(allGenres.isLeft, true);
          final MovieTmdbApiError left = allGenres.left as MovieTmdbApiError;
          expect(left.type, MovieTmdbApiErrorType.remote);
          expect(left.dioType, equals(DioExceptionType.connectionTimeout));
        },
      );
    });

    group("[MOVIES]\n", () {
      test(
        "EXPECT allGenres and result movies to be not empty WHEN getMovieThumbnails is called",
        () async {
          final repo = MovieTmdbApiRepository(dataSource: dataSourceAllWorking);
          const genre = Genre(id: 28, type: GenreType.movie, title: "Action");

          final movieThumbnails =
              await repo.getMovieThumbnails(forGenre: genre);

          expect(repo.allGenres, isNotEmpty);
          expect(movieThumbnails.right, isNotEmpty);
        },
      );

      test(
        "GIVEN data source movie not working from Connection timeout EXPECT return to be LEFT, and error type to be timeout WHEN calling getMovieThumbnails.",
        () async {
          final repo = MovieTmdbApiRepository(
              dataSource: MockTmdbApiDataSource(
                  dioException: CustomDioException.connectionTimeout()));
          const genre = Genre(id: 28, type: GenreType.movie, title: "Action");

          final movieThumbnails =
              await repo.getMovieThumbnails(forGenre: genre);

          expect(movieThumbnails.isLeft, true);
          expect(movieThumbnails.left.runtimeType, equals(MovieTmdbApiError));
          final error = movieThumbnails.left as MovieTmdbApiError;
          expect(error.type, MovieTmdbApiErrorType.remote);
          expect(error.dioType, equals(DioExceptionType.connectionTimeout));
        },
      );

      test(
        "GIVEN data source movie not working from bad response EXPECT return to be LEFT, and error type to be bad response WHEN calling getMovieThumbnails.",
        () async {
          final repo = MovieTmdbApiRepository(
              dataSource: MockTmdbApiDataSource(
                  dioException: CustomDioException.badResponse()));
          const genre = Genre(id: 28, type: GenreType.movie, title: "Action");

          final movieThumbnails =
              await repo.getMovieThumbnails(forGenre: genre);

          expect(movieThumbnails.isLeft, true);
          expect(movieThumbnails.left.runtimeType, equals(MovieTmdbApiError));
          final error = movieThumbnails.left as MovieTmdbApiError;
          expect(error.type, MovieTmdbApiErrorType.remote);
          expect(error.dioType, equals(DioExceptionType.badResponse));
        },
      );

      test(
          'GIVEN a data source that sends incorrect genreId EXPECT an Error of type empty results WHEN calling getMovieThumbnails',
          () async {
        final repo = MovieTmdbApiRepository(
            dataSource: const MockTmdbApiDataSource(
          movieResultsWithIncorrectGenreIds: true,
        ));
        const genre = Genre(id: 37, type: GenreType.movie, title: "?");
        // Mocked api results with id 37 don't contain any id 12 movie.

        final result = await repo.getMovieThumbnails(forGenre: genre);

        expect(result.isLeft, true);
        expect(result.left.runtimeType, equals(MovieTmdbApiError));
        final error = result.left as MovieTmdbApiError;
        expect(error.type, MovieTmdbApiErrorType.emptyResults);
        expect(error.dioType, equals(null));
      });

      test(
          'GIVEN a data source that sends empty results EXPECT an error of type empty results WHEN calling getMovieThumbnails',
          () async {
        final repo = MovieTmdbApiRepository(
            dataSource: const MockTmdbApiDataSource(
          movieEmptyResults: true,
        ));
        const genre = Genre(id: 37, type: GenreType.movie, title: "?");

        final result = await repo.getMovieThumbnails(forGenre: genre);

        expect(result.isLeft, true);
        expect(result.left.runtimeType, equals(MovieTmdbApiError));
        final error = result.left as MovieTmdbApiError;
        expect(error.type, MovieTmdbApiErrorType.emptyResults);
        expect(error.dioType, equals(null));
      });

      test(
          'GIVEN a data source that fails at retrieving allGenres EXPECT an error of type allGenresEmpty WHEN calling getMovieThumbnails',
          () async {
        final repo = MovieTmdbApiRepository(
            dataSource: MockTmdbApiDataSource(
                allGenresFailsWith: CustomDioException.badResponse()));
        const genre = Genre(id: 37, type: GenreType.movie, title: "?");

        final result = await repo.getMovieThumbnails(forGenre: genre);

        expect(result.isLeft, true);
        expect(result.left.runtimeType, equals(MovieTmdbApiError));
        final error = result.left as MovieTmdbApiError;
        expect(error.type, MovieTmdbApiErrorType.cantRetrieveGenres);
        expect(error.dioType, equals(DioExceptionType.badResponse));
      });
    });
  });
}
