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

  const SuccessMovieDetails({required this.movieDetails});
}

class FailureMovieDetails extends MovieDetailsState {
  final GetMovieDetailsError error;

  const FailureMovieDetails({required this.error});
}
