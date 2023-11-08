import 'package:flutter/material.dart';
import 'package:netflix_clone/data/tmdb_api/tmdb_api_service.dart';
import 'package:netflix_clone/data/tmdb_api/tmdb_custom_dio.dart';
import 'package:netflix_clone/models/dto/genre_dto.dart';

import 'models/entities/genre.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Material App',
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String result = "";
  final TmdbApiService tmdbApiService = TmdbApiService(TmdbCustomDio().dio);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Material App Bar'),
      ),
      body: ListView(
        children: [
          ElevatedButton(
            onPressed: () async {
              // final dto = await tmdbApiService.getMovieList(
              //   pageNumber: 3,
              //   withGenres: "Action",
              // );
              // final dto =
              //     await tmdbApiService.getPopularMovieList(pageNumber: 1);
              final tvDto = await tmdbApiService.getGenreTvList();
              final movieDto = await tmdbApiService.getGenreMovieList();

              print("Tv:\n");
              movieDto.genres.map((e) => e.toJson()).forEach(print);
              print('\nMovies:\n');
              tvDto.genres.map((res) => res.toJson()).forEach(print);

              final genres = <Genre>[];

              for (GenreDto genreDto in tvDto.genres) {
                genres.add(Genre(
                  title: genreDto.name,
                  id: genreDto.id,
                  type: GenreType.tvShow,
                ));
              }
              for (GenreDto genreDto in movieDto.genres) {
                genres.add(Genre(
                  title: genreDto.name,
                  id: genreDto.id,
                  type: GenreType.movie,
                ));
              }

              genres.forEach(print);

              setState(() {
                result = tvDto.genres.toString();
              });
            },
            child: const Text("call"),
          ),
          Text(
            result,
            maxLines: 100,
          )
        ],
      ),
    );
  }
}
