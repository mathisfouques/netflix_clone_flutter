import 'package:either_dart/either.dart';

import '../../data/tmdb_api/movie_tmdb_api_repository.dart';
import '../data_protocols/movie_data_protocol.dart';
import '../entities/movie_details.dart';

enum GetMovieDetailsErrorType { failingFetchingDetails, idMissmatch }

class GetMovieDetailsError {
  final Object error;
  final GetMovieDetailsErrorType type;

  GetMovieDetailsError({required this.error, required this.type});
}

class GetMovieDetailsUseCase {
  final int movieId;
  final MovieDataProtocol repo;

  const GetMovieDetailsUseCase({
    required this.movieId,
    required this.repo,
  });

  Future<Either<GetMovieDetailsError, MovieDetails>> call() async {
    final result = await repo.getMovieDetails(forMovieId: movieId);

    if (result.isLeft) {
      final movieProtocolError = result.left;

      if (movieProtocolError is MovieTmdbApiError &&
          movieProtocolError.type == MovieTmdbApiErrorType.idMissmatch) {
        return Left(GetMovieDetailsError(
          error: movieProtocolError.error,
          type: GetMovieDetailsErrorType.idMissmatch,
        ));
      }

      return Left(GetMovieDetailsError(
        error: movieProtocolError.error,
        type: GetMovieDetailsErrorType.failingFetchingDetails,
      ));
    }

    MovieDetails movieDetails = result.right;

    final credits = await repo.getMovieCredits(forMovieId: movieId);

    //TODO : Determine how to handle an error that is considered to be not really huge like this one.
    if (credits.isRight) {
      movieDetails = movieDetails.copyWith(credits: credits.right);
    }

    final trailers = await repo.getMovieTrailers(forMovieId: movieId);

    if (trailers.isRight) {
      movieDetails = movieDetails.copyWith(trailers: trailers.right);
    }

    return Right(movieDetails);
  }
}
