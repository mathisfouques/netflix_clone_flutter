import 'dart:math';

import 'package:either_dart/either.dart';
import 'package:equatable/equatable.dart';
import '../../data/tmdb_api/movie_tmdb_api_repository.dart';

import '../../list_extension.dart';
import '../data_protocols/movie_data_protocol.dart';
import '../entities/category_movies.dart';
import '../entities/genre.dart';

enum CategoryMoviesErrorType {
  failingFetchingGenres,
  tooMuchCategories,
  failingFetchingMovies
}

class GetCategoryMoviesUseCaseError extends Equatable {
  final Object error;
  final CategoryMoviesErrorType type;

  const GetCategoryMoviesUseCaseError(this.error, this.type);

  @override
  List<Object?> get props => [type];
}

class GetCategoryMoviesUseCase {
  final MovieDataProtocol repository;
  final int numberOfCategories;
  final GenreType? genreType;
  final List<Genre>? forGenres;

  GetCategoryMoviesUseCase({
    required this.repository,
    this.numberOfCategories = 8,
    this.genreType,
    this.forGenres,
  });

  int _randomIndex(int arrayLength) => Random().nextInt(arrayLength);

  /// Not tested because it would need api results for each genre to test it correctly.
  /// Randomly selects genres if not defined in the usecase with "forGenres"
  List<Genre> chooseGenreToDisplay(List<Genre> genresOfCorrectType) {
    if (forGenres != null) return forGenres!;

    final randomIndexes = <int>[];

    for (int i = 0; i < numberOfCategories; i++) {
      int randomIndex = _randomIndex(genresOfCorrectType.length);
      while (randomIndexes.contains(randomIndex)) {
        randomIndex = _randomIndex(genresOfCorrectType.length);
      }
      randomIndexes.add(randomIndex);
    }

    final categoryGenres =
        randomIndexes.mapToList((index) => genresOfCorrectType[index]);

    return categoryGenres;
  }

  Future<Either<GetCategoryMoviesUseCaseError, List<CategoryMovies>>>
      call() async {
    final retrieveGenres = await repository.getAllGenres(forType: genreType);
    if (retrieveGenres.isLeft) {
      return Left(GetCategoryMoviesUseCaseError(
        (retrieveGenres.left as MovieTmdbApiError).error,
        CategoryMoviesErrorType.failingFetchingGenres,
      ));
    }

    final genresOfCorrectType = retrieveGenres.right;

    if (forGenres == null && numberOfCategories > genresOfCorrectType.length) {
      return const Left(GetCategoryMoviesUseCaseError(
        "Requesting too much categories !",
        CategoryMoviesErrorType.tooMuchCategories,
      ));
    }

    final result = <CategoryMovies>[];
    for (Genre genre in chooseGenreToDisplay(genresOfCorrectType)) {
      final movieThumbnails =
          await repository.getMovieThumbnails(forGenre: genre);
      if (movieThumbnails.isLeft) {
        return Left(GetCategoryMoviesUseCaseError(
          (movieThumbnails.left as MovieTmdbApiError).error,
          CategoryMoviesErrorType.failingFetchingMovies,
        ));
      }

      result.add(CategoryMovies(
          isAdult: false, movies: movieThumbnails.right, genre: genre));
    }

    return Right(result);
  }
}
