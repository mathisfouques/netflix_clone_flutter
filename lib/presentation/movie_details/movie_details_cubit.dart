import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/data_protocols/movie_data_protocol.dart';
import '../../domain/entities/movie_details.dart';
import '../../domain/use_case/get_movie_details.dart';

part 'movie_details_state.dart';

class MovieDetailsCubit extends Cubit<MovieDetailsState> {
  final MovieDataProtocol movieRepo;

  MovieDetailsCubit({
    required this.movieRepo,
  }) : super(MovieDetailsInitial());

  fetchMovieDetails({required int forMovieId}) async {
    emit(LoadingMovieDetails());

    final result =
        await GetMovieDetailsUseCase(movieId: forMovieId, repo: movieRepo)();

    if (result.isRight) {
      emit(SuccessMovieDetails(movieDetails: result.right));
    } else {
      emit(FailureMovieDetails(error: result.left));
    }
  }

  dismiss() {
    if (state is SuccessMovieDetails) {
      emit(SuccessMovieDetails(
        movieDetails: (state as SuccessMovieDetails).movieDetails,
        isDismissed: true,
      ));
    }
  }
}
