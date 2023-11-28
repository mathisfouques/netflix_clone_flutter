import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:netflix_clone_mocks/mock/mock_tmdb_api_data_source.dart';

import '../colors.dart';
import '../domain/entities/category_movies.dart';
import '../domain/entities/movie_thumbnail.dart';
import '../list_extension.dart';
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

class CategoryMoviesListView extends StatelessWidget {
  final List<CategoryMovies> categories;

  const CategoryMoviesListView({super.key, required this.categories});

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.vertical,
      children: categories.mapToList(
        (category) => SizedBox(
          height: MediaQuery.of(context).size.height * 0.2,
          child: Column(
            children: [
              Text(category.genre.title,
                  style: const TextStyle(color: Colors.white)),
              const Gap(12),
              category.movies.isNotEmpty
                  ? Expanded(
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: category.movies
                            .mapToList<Widget>((movieThumbnail) =>
                                MovieThumbnailWidget(
                                    movieThumbnail: movieThumbnail))
                            .spaced(const Gap(8)),
                      ),
                    )
                  : Builder(builder: (context) {
                      print(category.movies);
                      print(category.genre.id);
                      return Container();
                    })
            ],
          ),
        ),
      ),
    );
  }
}

class MovieThumbnailWidget extends StatelessWidget {
  final MovieThumbnail movieThumbnail;

  const MovieThumbnailWidget({super.key, required this.movieThumbnail});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      child: CachedNetworkImage(
        imageUrl: movieThumbnail.portraitSourceImage,
        errorWidget: (context, url, error) {
          return Container(color: Colors.red);
        },
        errorListener: (value) {
          print(movieThumbnail);
        },
      ),
    );
  }
}
