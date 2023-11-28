part of 'movie_list_cubit.dart';

sealed class MovieListState extends Equatable {
  const MovieListState();

  @override
  List<Object> get props => [];
}

final class MovieListInitial extends MovieListState {}

final class SuccessFetchingMovieList extends MovieListState {
  final List<CategoryMovies> categories;

  const SuccessFetchingMovieList({required this.categories});
}

final class LoadingFetchingMovieList extends MovieListState {}

final class FailureFetchingMovieList extends MovieListState {
  final GetCategoryMoviesUseCaseError error;

  const FailureFetchingMovieList(this.error);
}
