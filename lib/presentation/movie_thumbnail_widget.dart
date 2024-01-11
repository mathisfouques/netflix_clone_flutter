import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../domain/entities/movie_thumbnail.dart';
import 'movie_details/movie_details_cubit.dart';

class MovieThumbnailWidget extends StatelessWidget {
  final MovieThumbnail movieThumbnail;

  const MovieThumbnailWidget({super.key, required this.movieThumbnail});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: InkWell(
          onTap: () {
            context
                .read<MovieDetailsCubit>()
                .fetchMovieDetails(forMovieId: movieThumbnail.tmdbId);
          },
          child: CachedNetworkImage(
            imageUrl: movieThumbnail.portraitSourceImage,
            errorWidget: (context, url, error) {
              return Container(
                color: Colors.green,
                child: Text(
                  "${movieThumbnail.tmdbId}cbivberuvber",
                  style: const TextStyle(color: Colors.black, fontSize: 35),
                ),
              );
            },
            errorListener: (value) {},
          ),
        ),
      ),
    );
  }
}
