import 'package:netflix_clone/data/tmdb_api/dto/movie_details/movie_credits_dto.dart';
import 'package:netflix_clone/data/tmdb_api/dto/movie_details/movie_details_dto.dart';
import 'package:netflix_clone/data/tmdb_api/dto/movie_details/movie_videos_dto.dart';
import 'package:netflix_clone/domain/entities/credits.dart';
import 'package:netflix_clone/domain/entities/genre.dart';
import 'package:netflix_clone/domain/entities/movie_details.dart';
import 'package:netflix_clone/domain/entities/trailer.dart';
import 'package:netflix_clone/list_extension.dart';
import 'package:netflix_clone_mocks/mock/tmdb_api_results/movie_videos/get_movie_videos_for_movie_670292.dart';

import 'tmdb_api_results/movie_credits/get_movie_credits_for_movie_670292.dart';
import 'tmdb_api_results/movie_details/get_movie_details_for_movie_670292.dart';

abstract class MovieTmdbRepositoryMockedCorrectValues {
  // The creator movie, used for mocking.
  static final correctMovieId = 670292;
  static final correctMovieDetailsDto =
      MovieDetailsDto.fromJson(getMovieDetailsForMovie670292);
  static MovieDetails get correctMovieDetails => MovieDetails(
        id: correctMovieDetailsDto.id,
        title: correctMovieDetailsDto.title,
        description: correctMovieDetailsDto.overview,
        genres: correctMovieDetailsDto.genres.mapToList(
            (dto) => Genre(id: dto.id, type: GenreType.movie, title: dto.name)),
        releaseYear: correctMovieDetailsDto.releaseDate.year,
      );

  final correctCreditsDto =
      MovieCreditsDto.fromJson(getMovieCreditsForMovie670292);
  static final correctCredits = Credits(
    forMovieId: correctMovieId,
    director: "Gareth Edwards",
    popularActors: ["Art Ybarra", "Elliot Berk", "Chalee Sankhavesa"],
  );

  static final correctMovieVideosDto =
      MovieVideosDto.fromJson(getMovieVideosForMovie670292);
  static List<Trailer> get correctTrailers => correctMovieVideosDto.results
      .whereToList(
          (element) => element.site == "YouTube" && element.type == "Trailer")
      .mapToList((dto) => Trailer(name: dto.name, youtubeKey: dto.key));
}
