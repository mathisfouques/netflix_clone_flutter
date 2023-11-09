import 'dart:math';

import '../../list_extension.dart';
import '../data_protocols/movie_data_protocol.dart';
import '../entities/category_movies.dart';
import '../entities/genre.dart';

class GetCategoryMoviesUseCase {
  final MovieDataProtocol repository;
  final int numberOfCategories;
  final GenreType? genreType;

  GetCategoryMoviesUseCase({
    required this.repository,
    required this.numberOfCategories,
    this.genreType,
  });

  int _randomIndex(int arrayLength) => Random().nextInt(arrayLength);

  Future<List<CategoryMovies>> call() async {
    final List<Genre> genresOfCorrectType =
        await repository.getAllGenres(forType: genreType);
    print(genresOfCorrectType);

    assert(numberOfCategories < genresOfCorrectType.length);

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
    final result = <CategoryMovies>[];

    for (Genre genre in categoryGenres) {
      final movieThumbnails =
          await repository.getMovieThumbnails(forGenre: genre);
      result.add(CategoryMovies(
          isAdult: false, movies: movieThumbnails, genre: genre));
    }

    return result;
  }
}
