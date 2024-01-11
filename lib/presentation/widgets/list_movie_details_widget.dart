import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../domain/entities/category_movies.dart';
import '../../list_extension.dart';
import '../movie_thumbnail_widget.dart';

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
