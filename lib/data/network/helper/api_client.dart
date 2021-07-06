import 'package:alia_movie/env/env.dart';
import 'package:dio/dio.dart';

class ApiClient {
  static Dio dio() {
    BaseOptions _baseOptions = BaseOptions(
      baseUrl: Env.apiUrl,
      connectTimeout: 5000,
      receiveTimeout: 5000,
      queryParameters: {
        'api_key': Env.apiKey,
      },
    );
    return Dio(_baseOptions);
  }
}
