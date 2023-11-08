import 'package:equatable/equatable.dart';

/// Assemble all information about one movie: date, realization, description, etc.
class Movie extends Equatable {
  /// The title of the movie.
  final String title;

  /// A brief overview or description of the movie.
  final String description;

  /// Genres associated with the movie (e.g., action, comedy, drama, etc.).
  final List<String> genres;

  /// The director of the movie.
  final String director;

  /// The year the movie was released.
  final int releaseYear;

  /// The movie's average user rating.
  final double rating;

  /// The URL to the movie's poster or cover image.
  final String imageUrl;

  /// The duration or runtime of the movie in minutes.
  final int duration;

  /// List of actors or cast members associated with the movie.
  final List<String> cast;

  /// The URL to stream the movie or the actual video content.
  final String videoUrl;

  /// A flag indicating if the movie has been marked as a favorite by the user.
  final bool isFavorite;

  /// A flag indicating if the user has already watched the movie.
  final bool isWatched;

  const Movie({
    required this.title,
    required this.description,
    required this.genres,
    required this.director,
    required this.releaseYear,
    required this.rating,
    required this.imageUrl,
    required this.duration,
    required this.cast,
    required this.videoUrl,
    required this.isFavorite,
    required this.isWatched,
  });

  @override
  List<Object?> get props => [
        title,
        description,
        genres,
        director,
        releaseYear,
        rating,
        imageUrl,
        duration,
        cast,
        videoUrl,
        isFavorite,
        isWatched,
      ];

  @override
  String toString() {
    return 'Movie(title: $title, description: $description, genres: $genres, director: $director, releaseYear: $releaseYear, rating: $rating, imageUrl: $imageUrl, duration: $duration, cast: $cast, videoUrl: $videoUrl, isFavorite: $isFavorite, isWatched: $isWatched)';
  }

  Movie copyWith({
    String? title,
    String? description,
    List<String>? genres,
    String? director,
    int? releaseYear,
    double? rating,
    String? imageUrl,
    int? duration,
    List<String>? cast,
    String? videoUrl,
    bool? isFavorite,
    bool? isWatched,
  }) {
    return Movie(
      title: title ?? this.title,
      description: description ?? this.description,
      genres: genres ?? this.genres,
      director: director ?? this.director,
      releaseYear: releaseYear ?? this.releaseYear,
      rating: rating ?? this.rating,
      imageUrl: imageUrl ?? this.imageUrl,
      duration: duration ?? this.duration,
      cast: cast ?? this.cast,
      videoUrl: videoUrl ?? this.videoUrl,
      isFavorite: isFavorite ?? this.isFavorite,
      isWatched: isWatched ?? this.isWatched,
    );
  }
}
