import 'package:alia_movie/data/model/base/base.dart';
import 'package:alia_movie/data/model/model.dart';
import 'package:alia_movie/data/network/network_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'network_repository_test.mocks.dart';

@GenerateMocks([NetworkRepository])
void main() {
  group('getMovies Test', () {
    test('getMovies Success Scenario', () async {
      final networkRepository = MockNetworkRepository();
      String title = 'Money';
      int page = 1;

      when(networkRepository.getMovies(title, page)).thenAnswer(
        (realInvocation) => Future.value(
          Base(
            page: page,
            results: [
              Movie(
                id: 10,
                title: 'Thor',
                overview: 'Thor great movie',
                imagePath: '/Hsnsau212.jpg',
                releaseDate: '2020-10-10',
              )
            ],
          ),
        ),
      );

      var res = await networkRepository.getMovies(title, page);
      expect(1, res.results.length);
      expect(page, res.page);
      expect('Thor', res.results[0].title);
    });

    test('getMovies Empty List Scenario', () async {
      final networkRepository = MockNetworkRepository();
      String title = 'Money';
      int page = 100;

      when(networkRepository.getMovies(title, page)).thenAnswer(
        (realInvocation) => Future.value(
          Base(
            page: page,
            results: [],
          ),
        ),
      );

      var res = await networkRepository.getMovies(title, page);
      expect(0, res.results.length);
      expect(page, res.page);
    });
  });

  group('getMovieHeader Test', () {
    test('getMovieHeader Success Scenario', () async {
      final networkRepository = MockNetworkRepository();

      when(networkRepository.getMovieHeader()).thenAnswer(
        (realInvocation) => Future.value(
          Movie(
            id: 10,
            title: 'Thor',
            overview: 'Thor great movie',
            imagePath: '/Hsnsau212.jpg',
            releaseDate: '2020-10-10',
          ),
        ),
      );

      var res = await networkRepository.getMovieHeader();
      expect('Thor', res.title);
    });

    test('getMovies Null Value Scenario', () async {
      final networkRepository = MockNetworkRepository();

      when(networkRepository.getMovieHeader()).thenAnswer(
        (realInvocation) => Future.value(
          Movie(
            id: 10,
            title: 'Thor',
            overview: null,
            imagePath: null,
            releaseDate: null,
          ),
        ),
      );

      var res = await networkRepository.getMovieHeader();
      expect('Thor', res.title);
      expect(null, res.overview);
      expect(null, res.imagePath);
      expect(null, res.releaseDate);
    });
  });
}
