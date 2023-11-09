import 'package:flutter_test/flutter_test.dart';
import 'package:netflix_clone/data/tmdb_api/movie_tmdb_api_repository.dart';

void main() {
  final repo = MovieTmdbApiRepository();

  test('Integration of all genres retrieval', () async {
    final genres = await repo.getAllGenres();

    expect(repo.allGenres, isNotEmpty);
  });
}
