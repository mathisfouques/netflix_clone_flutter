import 'package:equatable/equatable.dart';

/// The genre of the movie or tvShow. Can be "Action", "Adventure", etc. Refers the id of the genre.
class Genre extends Equatable {
  /// The ID of the genre in the TMDb database.
  final int id;

  /// Type of the genre: can be a movie or a TV show.
  final GenreType type;

  /// Name of the genre in English.
  final String title;

  const Genre({
    required this.id,
    required this.type,
    required this.title,
  });

  @override
  List<Object?> get props => [id, type, title];

  @override
  String toString() {
    return 'Genre(${type.name}) : $title';
  }

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

/// Type of the genre: is either a movie or a TV show.
enum GenreType {
  movie,
  tvShow,
}

extension GenreFromTmdb on Genre {
  static List<Genre> get tmdbGenres => const [
        Genre(
          id: 10759,
          type: GenreType.tvShow,
          title: "Action & Adventure",
        ),
        Genre(
          id: 16,
          type: GenreType.tvShow,
          title: "Animation",
        ),
        Genre(
          id: 35,
          type: GenreType.tvShow,
          title: "Comedy",
        ),
        Genre(
          id: 80,
          type: GenreType.tvShow,
          title: "Crime",
        ),
        Genre(
          id: 99,
          type: GenreType.tvShow,
          title: "Documentary",
        ),
        Genre(
          id: 18,
          type: GenreType.tvShow,
          title: "Drama",
        ),
        Genre(
          id: 10751,
          type: GenreType.tvShow,
          title: "Family",
        ),
        Genre(
          id: 10762,
          type: GenreType.tvShow,
          title: "Kids",
        ),
        Genre(
          id: 9648,
          type: GenreType.tvShow,
          title: "Mystery",
        ),
        Genre(
          id: 10763,
          type: GenreType.tvShow,
          title: "News",
        ),
        Genre(
          id: 10764,
          type: GenreType.tvShow,
          title: "Reality",
        ),
        Genre(
          id: 10765,
          type: GenreType.tvShow,
          title: "Sci-Fi & Fantasy",
        ),
        Genre(
          id: 10766,
          type: GenreType.tvShow,
          title: "Soap",
        ),
        Genre(
          id: 10767,
          type: GenreType.tvShow,
          title: "Talk",
        ),
        Genre(
          id: 10768,
          type: GenreType.tvShow,
          title: "War & Politics",
        ),
        Genre(
          id: 37,
          type: GenreType.tvShow,
          title: "Western",
        ),
        Genre(
          id: 28,
          type: GenreType.movie,
          title: "Action",
        ),
        Genre(
          id: 12,
          type: GenreType.movie,
          title: "Adventure",
        ),
        Genre(
          id: 16,
          type: GenreType.movie,
          title: "Animation",
        ),
        Genre(
          id: 35,
          type: GenreType.movie,
          title: "Comedy",
        ),
        Genre(
          id: 80,
          type: GenreType.movie,
          title: "Crime",
        ),
        Genre(
          id: 99,
          type: GenreType.movie,
          title: "Documentary",
        ),
        Genre(
          id: 18,
          type: GenreType.movie,
          title: "Drama",
        ),
        Genre(
          id: 10751,
          type: GenreType.movie,
          title: "Family",
        ),
        Genre(
          id: 14,
          type: GenreType.movie,
          title: "Fantasy",
        ),
        Genre(
          id: 36,
          type: GenreType.movie,
          title: "History",
        ),
        Genre(
          id: 27,
          type: GenreType.movie,
          title: "Horror",
        ),
        Genre(
          id: 10402,
          type: GenreType.movie,
          title: "Music",
        ),
        Genre(
          id: 9648,
          type: GenreType.movie,
          title: "Mystery",
        ),
        Genre(
          id: 10749,
          type: GenreType.movie,
          title: "Romance",
        ),
        Genre(
          id: 878,
          type: GenreType.movie,
          title: "Science Fiction",
        ),
        Genre(
          id: 10770,
          type: GenreType.movie,
          title: "TV Movie",
        ),
        Genre(
          id: 53,
          type: GenreType.movie,
          title: "Thriller",
        ),
        Genre(
          id: 10752,
          type: GenreType.movie,
          title: "War",
        ),
        Genre(
          id: 37,
          type: GenreType.movie,
          title: "Western",
        )
      ];
}
