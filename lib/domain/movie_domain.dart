import 'package:alia_movie/data/local/local_repository.dart';
import 'package:alia_movie/data/model/model.dart';
import 'package:alia_movie/data/network/network_repository.dart';

class MovieDomain {
  NetworkRepository _networkRepository = NetworkRepository();
  LocalRepository get _localRepository => getLocalRepositoryInstance;
  // Movie Header
  Future<Movie> getMovieHeader() {
    return _networkRepository.getMovieHeader();
  }

  // Search Movie
  Future<Base<List<Movie>>> getMovies(String title, int page) {
    return _networkRepository.getMovies(title, page);
  }

  // Add My Schedule Movie
  Future<void> addMySchedule(MovieScheduleCompanion movieScheduleData) async {
    await _localRepository.insertMovieSchedule(movieScheduleData);
  }
  
  // Read My Schedule Movie
  // Delete My Schedule Movie
  // Update My Schedule Movie
}
