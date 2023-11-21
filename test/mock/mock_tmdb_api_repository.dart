import 'package:either_dart/src/either.dart';
import 'package:netflix_clone/data/tmdb_api/data_source/tmdb_api_data_source.dart';
import 'package:netflix_clone/domain/data_protocols/movie_data_protocol.dart';
import 'package:netflix_clone/domain/entities/genre.dart';
import 'package:netflix_clone/domain/entities/movie_thumbnail.dart';

import 'mock_tmdb_api_data_source.dart';

class MockTmdbApiRepository implements MovieDataProtocol {
  final genresThatHaveAnApiResultMocked = <Genre>[
    const Genre(id: 28, type: GenreType.movie, title: "?"),
    const Genre(id: 53, type: GenreType.movie, title: "?"),
    const Genre(id: 12, type: GenreType.movie, title: "?"),
    const Genre(id: 37, type: GenreType.movie, title: "?"),
    const Genre(id: 36, type: GenreType.movie, title: "?"),
  ];
  final TmdbApiDataSource apiDataSource;

  MockTmdbApiRepository({this.apiDataSource = const MockTmdbApiDataSource()});

  @override
  Future<Either<MovieProtocolError, List<Genre>>> getAllGenres({
    GenreType? forType,
  }) async {
    final movieGenresDto = await apiDataSource.getGenreMovieList();
    final tvShowGenresDto = await apiDataSource.getGenreTvList();

    return Right([
      ...movieGenresDto.genres
          .map((dto) => Genre(id: dto.id, type: GenreType.movie, title: "?")),
      ...tvShowGenresDto.genres
          .map((dto) => Genre(id: dto.id, type: GenreType.tvShow, title: "?"))
    ]);
  }

  @override
  Future<Either<MovieProtocolError, List<MovieThumbnail>>> getMovieThumbnails({
    required Genre forGenre,
  }) async {
    final result = await apiDataSource.getMovieList(
        pageNumber: 1, withGenres: forGenre.id.toString());
    return const Right([]);
  }
}
