import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:netflix_clone/data/tmdb_api/data_source/tmdb_api_data_source.dart';
import 'package:netflix_clone/data/tmdb_api/tmdb_custom_dio.dart';
import 'package:netflix_clone/domain/use_case/get_category_movies.dart';

import '../../data/tmdb_api/movie_tmdb_api_repository.dart';
import '../../domain/entities/category_movies.dart';
import '../../domain/entities/genre.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final MovieTmdbApiRepository movieRepo = MovieTmdbApiRepository(
      dataSource: TmdbApiDataSource(TmdbCustomDio().dio));

  HomeCubit() : super(HomeInitial());

  fetchMovies({GenreType? genreType}) async {
    emit(LoadingHomeFetchMovies());
    try {
      final GetCategoryMoviesUseCase getCategoryMoviesUseCase =
          GetCategoryMoviesUseCase(
        repository: movieRepo,
        numberOfCategories: 10,
        genreType: genreType,
      );

      final categoryMoviesList = await getCategoryMoviesUseCase();

      emit(SuccessHomeFetchMovies(categories: categoryMoviesList));
    } catch (e, stacktrace) {
      final errorMessage = "Error in HomeCubit. $e : $stacktrace";
      print(errorMessage);
      emit(FailureHomeFetchMovies(errorMessage));
    }
  }
}
