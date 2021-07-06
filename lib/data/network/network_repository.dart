import 'package:alia_movie/data/model/model.dart';
import 'package:alia_movie/data/network/api_routes.dart';
import 'package:alia_movie/data/network/helper/api_helper_impl.dart';

class NetworkRepository {
  ApiHelperImpl _apiHelper = ApiHelperImpl();

  Future<Base<List<Movie>>> getMovies(String title, int page) async {
    var response = await _apiHelper.get(
      ApiRoutes.SEARCH_MOVIE,
      queryParameters: {
        'query': title,
        'page': page,
      },
    );

    var result = Base<List<Movie>>.fromJson(response.data,
        (json) => (json as List).map((e) => Movie.fromJson(e)).toList());
    return result;
  }

  Future<Movie> getMovieHeader() async {
    var response = await _apiHelper.get(ApiRoutes.MOVIE_HEADER);

    var result = Movie.fromJson(response.data);
    return result;
  }
}
