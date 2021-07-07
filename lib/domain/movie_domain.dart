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
  Future<void> addMovieSchedule(
      MovieScheduleCompanion movieScheduleData) async {
    await _localRepository.insertMovieSchedule(movieScheduleData);
  }

  // Is Moview Schdule Exist
  Future<bool> isMovieScheduleAdded(int id) async {
    return await _localRepository.isMovieScheduleAdded(id);
  }

  // Read My Schedule Movie
  Stream<List<MovieScheduleData>> watchMovieSchedule() {
    return _localRepository.getMovieScheduleStream();
  }

  // Delete My Schedule Movie
  Future<void> deleteMovieSchedule(
      MovieScheduleCompanion movieScheduleData) async {
    await _localRepository.deleteMovieSchedule(movieScheduleData);
  }

  // Update My Schedule Movie
  Future<void> updateMovieSchedule(
      MovieScheduleCompanion movieScheduleData) async {
    await _localRepository.updateMovieSchedule(movieScheduleData);
  }
}
