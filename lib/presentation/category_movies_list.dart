import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../domain/entities/category_movies.dart';
import '../domain/entities/movie_details.dart';
import '../domain/use_case/get_movie_details.dart';
import '../list_extension.dart';
import 'movie_details/movie_details_cubit.dart';
import 'movie_thumbnail_widget.dart';

class CategoryMoviesListView extends StatelessWidget {
  final List<CategoryMovies> categories;

  const CategoryMoviesListView({super.key, required this.categories});

  @override
  Widget build(BuildContext context) {
    return BlocListener<MovieDetailsCubit, MovieDetailsState>(
      listener: (context, state) {
        if (state is SuccessMovieDetails) {
          _showMovieDetails(context, details: state.movieDetails);
        }

        if (state is FailureMovieDetails) {
          _showErrorForMovieDetails(state.error);
        }
      },
      child: ListView(
        scrollDirection: Axis.vertical,
        children: categories.mapToList(
          (category) => SizedBox(
            height: MediaQuery.of(context).size.height * 0.2,
            child: Column(
              children: [
                Text(category.genre.title,
                    style: const TextStyle(color: Colors.white)),
                const Gap(12),
                if (category.movies.isNotEmpty)
                  Expanded(
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: category.movies
                          .mapToList<Widget>((movieThumbnail) =>
                              MovieThumbnailWidget(
                                  movieThumbnail: movieThumbnail))
                          .spaced(const Gap(8)),
                    ),
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void _showErrorForMovieDetails(GetMovieDetailsError error) {
  print(error);
}

void _showMovieDetails(
  BuildContext context, {
  required MovieDetails details,
}) {
  // showCupertinoDialog(
  //   context: context,
  //   builder: (context) => _builder(context, details),
  // );

  // showCupertinoModalPopup(
  //   context: context,
  //   builder: (context) => _builder(context, details),
  // );

  // showDialog(
  //   useSafeArea: false,
  //   context: context,
  //   builder: (context) => _builder(context, details),
  // );

  showBottomSheet(
      enableDrag: true,
      backgroundColor: Colors.transparent,
      elevation: 4,
      context: context,
      builder: (context) => _builder(context, details));
}

Widget _builder(BuildContext context, MovieDetails details) => SafeArea(
      bottom: false,
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
        child: Container(
          // height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            color: Colors.amber,
          ),
          child: Column(
            children: [
              Text(details.title),
              const Spacer(),
            ],
          ),
        ),
      ),
    );

class MovieDetailsBottomSheetContent extends StatelessWidget {
  const MovieDetailsBottomSheetContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
