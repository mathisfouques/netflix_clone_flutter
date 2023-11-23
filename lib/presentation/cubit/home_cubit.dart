import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';


import '../../domain/use_case/get_category_movies.dart';
import '../../data/tmdb_api/movie_tmdb_api_repository.dart';
import '../../domain/entities/category_movies.dart';
import '../../domain/entities/genre.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final MovieTmdbApiRepository movieRepo;

  HomeCubit({required this.movieRepo}) : super(HomeInitial());

  fetchMovies({
    GenreType? genreType,
    List<Genre>? forGenres,
    int? numberOfCategories,
  }) async {
    emit(LoadingHomeFetchMovies());

    final GetCategoryMoviesUseCase getCategoryMoviesUseCase =
        GetCategoryMoviesUseCase(
      repository: movieRepo,
      numberOfCategories: numberOfCategories ?? 8,
      genreType: genreType,
      forGenres: forGenres,
    );

    final useCaseResult = await getCategoryMoviesUseCase();

    if (useCaseResult.isRight) {
      emit(SuccessHomeFetchMovies(categories: useCaseResult.right));
    } else {
      emit(FailureHomeFetchMovies(useCaseResult.left));
    }
  }
}
