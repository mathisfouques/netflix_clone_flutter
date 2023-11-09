import 'package:equatable/equatable.dart';

import 'genre.dart';
import 'movie_thumbnail.dart';

/// Contains a list of movies that correspond to a specific genre.
class CategoryMovies extends Equatable {
  /// Indicates whether the content is for adults.
  final bool isAdult;

  /// List of movie thumbnails for this category.
  final List<MovieThumbnail> movies;

  /// The genre associated with these movies.
  final Genre genre;

  const CategoryMovies({
    required this.isAdult,
    required this.movies,
    required this.genre,
  });

  @override
  List<Object?> get props => [isAdult, movies, genre];

  @override
  String toString() {
    return 'CategoryMovies(isAdult: $isAdult, movies: $movies, genre: $genre)';
  }

  CategoryMovies copyWith({
    bool? isAdult,
    List<MovieThumbnail>? movies,
    Genre? genre,
  }) {
    return CategoryMovies(
      isAdult: isAdult ?? this.isAdult,
      movies: movies ?? this.movies,
      genre: genre ?? this.genre,
    );
  }
}
