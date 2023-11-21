import 'package:flutter_test/flutter_test.dart';
import 'package:netflix_clone/data/tmdb_api/movie_tmdb_api_repository.dart';
import 'package:netflix_clone/domain/entities/genre.dart';
import 'package:netflix_clone/domain/use_case/get_category_movies.dart';
import 'package:netflix_clone/list_extension.dart';

import 'mock/mock_tmdb_api_data_source.dart';
import 'movie_tmdb_api_repository_test.dart';

void main() {
  group("\n[GET CATEGORY MOVIES]", () {
    final genresThatHaveAnApiResultMocked = <Genre>[
      const Genre(id: 28, type: GenreType.movie, title: "?"),
      const Genre(id: 53, type: GenreType.movie, title: "?"),
      const Genre(id: 12, type: GenreType.movie, title: "?"),
      const Genre(id: 37, type: GenreType.movie, title: "?"),
      const Genre(id: 36, type: GenreType.movie, title: "?"),
    ];

    test(
      'GIVEN a data source with failing genres call EXPECT a UseCaseError WHEN calling usecase',
      () async {
        final repo = MovieTmdbApiRepository(
            dataSource: MockTmdbApiDataSource(
          allGenresFailsWith: CustomDioException.badResponse(),
        ));
        final usecase = GetCategoryMoviesUseCase(
          repository: repo,
          numberOfCategories: 1,
        );

        final result = await usecase();

        expect(result.isLeft, true);
        final left = result.left;
        expect(left.type, CategoryMoviesErrorType.failingFetchingGenres);
      },
    );

    test(
        'GIVEN a data source successful but too much categories requested, EXPECT a UseCaseError with type tooMuchCategories WHEN calling usecase.',
        () async {
      final repo = MovieTmdbApiRepository(dataSource: const MockTmdbApiDataSource());
      final usecase = GetCategoryMoviesUseCase(
        repository: repo,
        numberOfCategories: 100,
      );

      final result = await usecase();

      expect(result.isLeft, true);
      expect(result.left.type, CategoryMoviesErrorType.tooMuchCategories);
    });

    test(
        'GIVEN a data source sucessful EXPECT 8 CategoryMovies with NotEmpty list of MovieThumbnails WHEN calling usecase.',
        () async {
      final repo = MovieTmdbApiRepository(dataSource: const MockTmdbApiDataSource());
      final usecase = GetCategoryMoviesUseCase(
        repository: repo,
        forGenres: genresThatHaveAnApiResultMocked,
      );

      final result = await usecase();

      expect(result.isRight, true);
      expect(result.right.length, genresThatHaveAnApiResultMocked.length);
      expect(result.right.mapToList((e) => e.genre),
          genresThatHaveAnApiResultMocked);
      expect(result.right..retainWhere((element) => element.movies.isEmpty),
          isEmpty);
    });

    test(
      'GIVEN data source with failing movie call EXPECT Usecase error with type failingFetchMovies WHEN calling usecase.',
      () async {
        final repo = MovieTmdbApiRepository(
            dataSource: MockTmdbApiDataSource(
                dioException: CustomDioException.badResponse()));
        final usecase = GetCategoryMoviesUseCase(
          repository: repo,
          forGenres: genresThatHaveAnApiResultMocked,
        );

        final result = await usecase();

        expect(result.isLeft, true);
        expect(result.left.type, CategoryMoviesErrorType.failingFetchingMovies);
      },
    );
  });
}
