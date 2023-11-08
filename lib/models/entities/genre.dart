/// The category of the movie or TV show.
enum Genre {
  action(
    title: 'Action',
    id: 0,
    type: GenreType.movie,
  ),
  adventure(
    title: 'Adventure',
    id: 1,
    type: GenreType.tvShow,
  ),
  documentary(
    title: 'Documentary',
    id: 2,
    type: GenreType.movie,
  );

  final String title;
  final GenreType type;
  final int id;

  const Genre({
    required this.title,
    required this.id,
    required this.type,
  });
}

/// Type of the genre: is either a movie or a TV show.
enum GenreType {
  movie,
  tvShow,
}
