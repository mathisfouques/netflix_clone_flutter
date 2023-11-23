import 'package:equatable/equatable.dart';

import 'genre.dart';
import 'movie_thumbnail.dart';

/// Contains a list of movies that corresponds to the proper genre in the class
///
/// Parameters:
/// - `isAdult`: Indicates if the category contains adult content.
/// - `movies`: A list of movie thumbnails.
/// - `genre`: The genre of the movies in this category.
class CategoryMovies extends Equatable {
  final bool isAdult;
  final List<MovieThumbnail> movies;
  final Genre genre;

  /// Constructor for `CategoryMovies`.
  const CategoryMovies({
    required this.isAdult,
    required this.movies,
    required this.genre,
  });

  @override
  List<Object?> get props => [isAdult, movies, genre];

  @override
  String toString() =>
      'CategoryMovies(isAdult: $isAdult, movies: $movies, genre: $genre)';

  /// Returns a copy of this `CategoryMovies` but with the given fields replaced with new values.
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
