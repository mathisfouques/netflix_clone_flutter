import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/use_case/get_category_movies.dart';
import '../../data/tmdb_api/movie_tmdb_api_repository.dart';
import '../../domain/entities/category_movies.dart';
import '../../domain/entities/genre.dart';

part 'movie_list_state.dart';

class MovieListCubit extends Cubit<MovieListState> {
  final MovieTmdbApiRepository movieRepo;

  MovieListCubit({required this.movieRepo}) : super(MovieListInitial());

  fetchMovies({
    GenreType? genreType,
    List<Genre>? forGenres,
    int? numberOfCategories,
  }) async {
    emit(LoadingFetchingMovieList());

    final GetCategoryMoviesUseCase getCategoryMoviesUseCase =
        GetCategoryMoviesUseCase(
      repository: movieRepo,
      numberOfCategories: numberOfCategories ?? 8,
      genreType: genreType,
      forGenres: forGenres,
    );

    final useCaseResult = await getCategoryMoviesUseCase();

    if (useCaseResult.isRight) {
      emit(SuccessFetchingMovieList(categories: useCaseResult.right));
    } else {
      emit(FailureFetchingMovieList(useCaseResult.left));
    }
  }
}
