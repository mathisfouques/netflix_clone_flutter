part of 'home_cubit.dart';

sealed class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

final class HomeInitial extends HomeState {}

// HOME FETCH MOVIES

sealed class HomeFetchMovies extends HomeState {
  const HomeFetchMovies();
}

final class SuccessHomeFetchMovies extends HomeFetchMovies {
  final List<CategoryMovies> categories;

  const SuccessHomeFetchMovies({required this.categories});
}

final class LoadingHomeFetchMovies extends HomeFetchMovies {}

final class FailureHomeFetchMovies extends HomeFetchMovies {
  final GetCategoryMoviesUseCaseError error;

  const FailureHomeFetchMovies(this.error);
}
