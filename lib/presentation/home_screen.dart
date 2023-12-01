import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix_clone_mocks/mock/mock_tmdb_api_data_source.dart';

import '../colors.dart';
import 'category_movies_list.dart';
import 'movie_list_cubit/movie_list_cubit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String result = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UiColors.darkGrey,
      body: BlocBuilder<MovieListCubit, MovieListState>(
          builder: (context, state) {
        switch (state) {
          case SuccessFetchingMovieList():
            return CategoryMoviesListView(categories: state.categories);
          case LoadingFetchingMovieList():
            return const Center(
                child: CircularProgressIndicator.adaptive(
              backgroundColor: Colors.white,
            ));
          case FailureFetchingMovieList():
            return Center(
                child: Text(
              state.error.type.name,
              style: const TextStyle(color: Colors.white),
            ));
          default:
            if (state is MovieListInitial) {
              context.read<MovieListCubit>().fetchMovies(
                  forGenres:
                      MockTmdbApiDataSource.genresThatHaveAnApiResultMocked);
            }
            return Container();
        }
      }),
    );
  }
}
