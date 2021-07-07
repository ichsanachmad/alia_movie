import 'package:alia_movie/bloc/get_movie_schedule_detail/get_movie_schedule_detail_event.dart';
import 'package:alia_movie/bloc/get_movie_schedule_detail/get_movie_schedule_detail_state.dart';
import 'package:alia_movie/data/local/local_repository.dart';
import 'package:alia_movie/domain/movie_domain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GetMovieScheduleDetailBloc
    extends Bloc<GetMovieScheduleDetailEvent, GetMovieScheduleDetailState> {
  GetMovieScheduleDetailBloc() : super(GetMovieScheduleDetailState());
  MovieDomain _movieDomain = MovieDomain();

  @override
  Stream<GetMovieScheduleDetailState> mapEventToState(
      GetMovieScheduleDetailEvent event) async* {
    if (event is GetMovieScheduleDetailEvent) {
      yield* _mapGetMovieScheduleDetailToState(event.id);
    }
  }

  Stream<GetMovieScheduleDetailState> _mapGetMovieScheduleDetailToState(
      int id) async* {
    try {
      var res = await _movieDomain.getMovieScheduleDetail(id);
      yield GetMovieScheduleDetailSuccessState(movies: res);
    } catch (e) {
      yield GetMovieScheduleDetailErrorState(
          message: 'Failed Load Detail Schedule');
    }
  }
}
