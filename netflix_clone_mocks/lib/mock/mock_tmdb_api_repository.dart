import 'package:netflix_clone/data/tmdb_api/dto/genre/genre_list_dto.dart';
import 'package:netflix_clone/data/tmdb_api/dto/movie_details/movie_credits_dto.dart';
import 'package:netflix_clone/data/tmdb_api/dto/movie_details/movie_details_dto.dart';
import 'package:netflix_clone/data/tmdb_api/dto/movie_details/movie_videos_dto.dart';
import 'package:netflix_clone/data/tmdb_api/dto/movie_list/movie_list_dto.dart';
import 'package:netflix_clone/domain/entities/credits.dart';
import 'package:netflix_clone/domain/entities/genre.dart';
import 'package:netflix_clone/domain/entities/movie_details.dart';
import 'package:netflix_clone/domain/entities/movie_thumbnail.dart';
import 'package:netflix_clone/domain/entities/trailer.dart';
import 'package:netflix_clone/list_extension.dart';
import 'package:netflix_clone_mocks/mock/tmdb_api_results/movie_similar/get_similar_movies_for_movie_670292.dart';
import 'package:netflix_clone_mocks/mock/tmdb_api_results/movie_videos/get_movie_videos_for_movie_670292.dart';
import 'package:netflix_clone_mocks/netflix_clone_mocks.dart';

abstract class MovieTmdbRepositoryMockedCorrectValues {
  static final _imageBaseUrl = "https://image.tmdb.org/t/p/";
  static final _posterDefaultSize = "w185";

  static final allMovieGenres = GenreListDto.fromJson(mockGetGenreMovieList)
      .genres
      .mapToList((dto) => Genre(
            id: dto.id,
            type: GenreType.movie,
            title: dto.name,
          ));
  static final alTvShowGenres =
      GenreListDto.fromJson(mockGetGenreTvList).genres.mapToList((dto) => Genre(
            id: dto.id,
            type: GenreType.movie,
            title: dto.name,
          ));

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
        releaseYear:
            DateTime.tryParse(correctMovieDetailsDto.releaseDate)?.year,
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

  static final correctSimilarMoviesDto =
      MovieListDto.fromJson(getSimilarMoviesForMovie670292);
  static List<MovieThumbnail> correctSimilarMovies =
      correctSimilarMoviesDto.results.mapToList(
    (dto) => MovieThumbnail(
      isAdult: dto.adult,
      tmdbId: dto.id,
      genres: dto.genreIds.mapToList((genreId) {
        final allGenres = [...allMovieGenres, ...alTvShowGenres];
        return allGenres.firstWhere((element) => element.id == genreId);
      }),
      portraitSourceImage: _imageBaseUrl + _posterDefaultSize + dto.posterPath,
    ),
  );
}
