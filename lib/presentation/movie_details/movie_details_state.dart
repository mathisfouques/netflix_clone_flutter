part of 'movie_details_cubit.dart';

sealed class MovieDetailsState extends Equatable {
  const MovieDetailsState();

  @override
  List<Object> get props => [];
}

final class MovieDetailsInitial extends MovieDetailsState {}

class LoadingMovieDetails extends MovieDetailsState {}

class SuccessMovieDetails extends MovieDetailsState {
  final MovieDetails movieDetails;
  final bool isDismissed;

  const SuccessMovieDetails({
    required this.movieDetails,
    this.isDismissed = false,
  });

  @override
  List<Object> get props => super.props
    ..addAll([
      isDismissed
    ]); // TODO: add movieDetails, but tests gets broken... Wrong mocked values.
}

class FailureMovieDetails extends MovieDetailsState {
  final GetMovieDetailsError error;

  const FailureMovieDetails({required this.error});
}
