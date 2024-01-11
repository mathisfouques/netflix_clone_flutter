import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../domain/entities/category_movies.dart';
import 'movie_details/movie_details_cubit.dart';
import 'widgets/list_movie_details_widget.dart';
import 'widgets/movie_details_bottom_sheet_content.dart';

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
        showCupertinoModalPopup(
          context: context,
          builder: (context) => MovieDetailsBottomSheetContent(
            details: state.movieDetails,
          ),
        );
      }

      if (state is FailureMovieDetails) {
        print(state.error);
      }
    }, builder: (context, state) {
      return ListMovieDetailsWidget(categories: widget.categories);
    });
  }
}


// TODO : Try with a stack. Idea was to replicate exactly the effect from netflix itself.

 // if (state is SuccessMovieDetails && !state.isDismissed)
    //   AnimatedBuilder(
    //     animation: offsetForSuccessState,
    //     builder: (context, child) => Positioned(
    //       top: MediaQuery.of(context).size.height * (1 - 0.9) +
    //           offsetForSuccessState.value.dy,
    //       left: offsetForSuccessState.value.dx,
    //       child: child!,
    //     ),
    //     child: Draggable(
    //       onDragStarted: () {
    //         print("called onDragStarted");
    //       },
    //       onDragUpdate: (details) {
    //         print(details);

    //         offsetForSuccessState.value = Offset(
    //           offsetForSuccessState.value.dx + details.delta.dx,
    //           offsetForSuccessState.value.dy + details.delta.dy,
    //         );
    //       },
    //       onDragEnd: (details) {
    //         final onDragEndOffset = details.offset;

    //         if (onDragEndOffset.dy.abs() > 2 ||
    //             onDragEndOffset.dx.abs() > 2) {
    //           print(
    //               "called dismiss : ${onDragEndOffset.dy}, ${onDragEndOffset.dx}}");
    //           context.read<MovieDetailsCubit>().dismiss();

    //           return;
    //         }

    //         StreamSubscription? sub;
    //         const int iterations = 20;

    //         sub = Stream.periodic(
    //                 const Duration(milliseconds: 5), (i) => i + 1)
    //             .take(iterations)
    //             .listen((event) {
    //           offsetForSuccessState.value = Offset(
    //             0 +
    //                 (iterations - event) *
    //                     (onDragEndOffset.dx / iterations),
    //             0 +
    //                 (iterations - event) *
    //                     (onDragEndOffset.dy / iterations),
    //           );
    //         });

    //         sub.onDone(() {
    //           sub?.cancel();
    //         });
    //       },
    //       feedback: Container(),
    //       child: MovieDetailsBottomSheetContent(
    //           details: state.movieDetails),
    //     ),
    //   ),
    // ],
