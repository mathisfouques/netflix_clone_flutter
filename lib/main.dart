import 'package:flutter/material.dart';
import 'package:netflix_clone/data/tmdb_api/movie_service.dart';
import 'package:netflix_clone/data/tmdb_api/tmdb_custom_dio.dart';

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
              final dto =
                  await tmdbApiService.getPopularMovieList(pageNumber: 1);

              dto.results.map((res) => res.toJson()).forEach(print);

              setState(() {
                result = dto.results.toString();
              });
            },
            child: const Text("makeCall"),
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
