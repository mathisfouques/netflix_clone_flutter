import 'dart:async';

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

class CategoryMoviesListView extends StatefulWidget {
  final List<CategoryMovies> categories;

  const CategoryMoviesListView({super.key, required this.categories});

  @override
  State<CategoryMoviesListView> createState() => _CategoryMoviesListViewState();
}

class _CategoryMoviesListViewState extends State<CategoryMoviesListView> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MovieDetailsCubit, MovieDetailsState>(
      listener: (context, state) {
        if (state is SuccessMovieDetails) {
          print(state);
        }

        if (state is FailureMovieDetails) {
          _showErrorForMovieDetails(state.error);
        }
      },
      builder: (context, state) {
        final ValueNotifier<Offset> offsetForSuccessState =
            ValueNotifier(Offset.zero);

        return Stack(
          children: [
            ListMovieDetailsWidget(categories: widget.categories),
            if (state is SuccessMovieDetails && !state.isDismissed)
              AnimatedBuilder(
                animation: offsetForSuccessState,
                builder: (context, child) => Positioned(
                  top: MediaQuery.of(context).size.height * (1 - 0.9) +
                      offsetForSuccessState.value.dy,
                  left: offsetForSuccessState.value.dx,
                  child: child!,
                ),
                child: Draggable(
                  onDragStarted: () {
                    print("called onDragStarted");
                  },
                  onDragUpdate: (details) {
                    print(details);

                    offsetForSuccessState.value = Offset(
                      offsetForSuccessState.value.dx + details.delta.dx,
                      offsetForSuccessState.value.dy + details.delta.dy,
                    );
                  },
                  onDragEnd: (details) {
                    final onDragEndOffset = details.offset;
                    if (onDragEndOffset.dy.abs() > 2 ||
                        onDragEndOffset.dx.abs() > 2) {
                      print(
                          "called dismiss : ${onDragEndOffset.dy}, ${onDragEndOffset.dx}}");
                      context.read<MovieDetailsCubit>().dismiss();

                      return;
                    }

                    StreamSubscription? sub;
                    const int iterations = 20;

                    sub = Stream.periodic(
                            const Duration(milliseconds: 5), (i) => i + 1)
                        .take(iterations)
                        .listen((event) {
                      offsetForSuccessState.value = Offset(
                        0 +
                            (iterations - event) *
                                (onDragEndOffset.dx / iterations),
                        0 +
                            (iterations - event) *
                                (onDragEndOffset.dy / iterations),
                      );
                    });

                    sub.onDone(() {
                      sub?.cancel();
                    });
                  },
                  feedback: Container(),
                  child: MovieDetailsBottomSheetContent(
                      details: state.movieDetails),
                ),
              ),
          ],
        );
      },
    );
  }
}

class ListMovieDetailsWidget extends StatelessWidget {
  const ListMovieDetailsWidget({
    super.key,
    required this.categories,
  });

  final List<CategoryMovies> categories;

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
    );
  }
}

void _showErrorForMovieDetails(GetMovieDetailsError error) {
  print(error);
}

class MovieDetailsBottomSheetContent extends StatelessWidget {
  final MovieDetails details;

  const MovieDetailsBottomSheetContent({super.key, required this.details});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.9,
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
  }
}
