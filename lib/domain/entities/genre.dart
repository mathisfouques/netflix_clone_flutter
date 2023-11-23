import 'package:equatable/equatable.dart';

/// The genre of the movie or tvShow. Can be "Action", "Adventure", etc. Refers the id of the genre.
///
/// Parameters:
/// - `id`: Id of the genre in tmdb database.
/// - `type`: Type of the genre: is either a movie or a tv show.
/// - `title`: Name of the genre (English).
class Genre extends Equatable {
  final int id;
  final GenreType type;
  final String title;

  /// Constructor for `Genre`.
  const Genre({
    required this.id,
    required this.type,
    required this.title,
  });

  @override
  List<Object?> get props => [id, type, title];

  @override
  String toString() => 'Genre(id: $id, type: $type, title: $title)';

  /// Returns a copy of this `Genre` but with the given fields replaced with new values.
  Genre copyWith({
    int? id,
    GenreType? type,
    String? title,
  }) {
    return Genre(
      id: id ?? this.id,
      type: type ?? this.type,
      title: title ?? this.title,
    );
  }
}

/// Type of the genre: is either a movie or a tv show.
enum GenreType {
  movie,
  tvShow;

  @override
  String toString() {
    switch (this) {
      case GenreType.movie:
        return 'Movie';
      case GenreType.tvShow:
        return 'TV Show';
      default:
        return 'Unknown';
    }
  }
}
