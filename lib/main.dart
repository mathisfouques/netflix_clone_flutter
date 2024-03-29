import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix_clone_mocks/mock/mock_tmdb_api_data_source.dart';
import 'data/tmdb_api/data_source/tmdb_api_data_source.dart';
import 'data/tmdb_api/tmdb_custom_dio.dart';
import 'presentation/movie_details/movie_details_cubit.dart';
import 'presentation/movie_list_cubit/movie_list_cubit.dart';

import 'data/tmdb_api/movie_tmdb_api_repository.dart';
import 'presentation/home_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppProviders(
      child: MaterialApp(
        title: 'Material App',
        home: HomeScreen(),
      ),
    );
  }
}

class AppProviders extends StatelessWidget {
  final Widget child;

  const AppProviders({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    const mockedDataSource = MockTmdbApiDataSource();
    final dataSource = TmdbApiDataSource(TmdbCustomDio().dio);

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => MovieListCubit(
              movieRepo: MovieTmdbApiRepository(dataSource: mockedDataSource))
            ..fetchMovies(
                forGenres:
                    MockTmdbApiDataSource.genresThatHaveAnApiResultMocked),
        ),
        BlocProvider(
          create: (context) => MovieDetailsCubit(
              movieRepo: MovieTmdbApiRepository(dataSource: mockedDataSource)),
        )
      ],
      child: child,
    );
  }
}
