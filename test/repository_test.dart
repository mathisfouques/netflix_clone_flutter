import 'package:flutter_test/flutter_test.dart';
import 'package:netflix_clone/data/tmdb_api/movie_tmdb_api_repository.dart';

import 'mock_tmdb_api_data_source.dart';

void main() {
  final repo = MovieTmdbApiRepository(dataSource: MockTmdbApiDataSource());

  group('Integration of all genres retrieval', () {
    test(
      "Expect the repositories to retrieve allGenres When getAllGenres is called",
      () async {
        await repo.getAllGenres();

        expect(repo.allGenres, isNotEmpty);
      },
    );
  });
}
