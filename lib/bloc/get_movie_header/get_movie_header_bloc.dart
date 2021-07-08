import 'package:alia_movie/bloc/get_movie_header/get_movie_header_event.dart';
import 'package:alia_movie/bloc/get_movie_header/get_movie_header_state.dart';
import 'package:alia_movie/domain/movie_domain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GetMovieHeaderBloc
    extends Bloc<GetMovieHeaderEvent, GetMovieHeaderState> {
  GetMovieHeaderBloc() : super(GetMovieHeaderState());
  MovieDomain _movieDomain = MovieDomain();
  
  @override
  Stream<GetMovieHeaderState> mapEventToState(
      GetMovieHeaderEvent event) async* {
    if (event is GetMovieHeaderEvent) {
      yield* _mapMovieHeaderToState();
    }
  }

  Stream<GetMovieHeaderState> _mapMovieHeaderToState() async* {
    try {
      var res = await _movieDomain.getMovieHeader();
      yield GetMovieHeaderSuccessState(movie: res);
    } catch (e) {
      yield GetMovieHeaderErrorState(message: e.toString());
    }
  }
}
