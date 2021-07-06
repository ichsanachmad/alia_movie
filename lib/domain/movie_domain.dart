import 'package:alia_movie/data/model/model.dart';
import 'package:alia_movie/data/network/network_repository.dart';

class MovieDomain {
  NetworkRepository _networkRepository = NetworkRepository();

  // Search Movie
  Future<Base<List<Movie>>> searchMovie(String title, int page) {
    return _networkRepository.searchMovie(title, page);
  }

  // Add My Schedule Movie
  // Read My Schedule Movie
  // Delete My Schedule Movie
  // Update My Schedule Movie
}
