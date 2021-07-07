import 'package:alia_movie/bloc/update_movie_schedule/update_movie_schedule_event.dart';
import 'package:alia_movie/bloc/update_movie_schedule/update_movie_schedule_state.dart';
import 'package:alia_movie/data/local/local_repository.dart';
import 'package:alia_movie/domain/movie_domain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdateMovieScheduleBloc
    extends Bloc<UpdateMovieScheduleEvent, UpdateMovieScheduleState> {
  UpdateMovieScheduleBloc() : super(UpdateMovieScheduleState());
  MovieDomain _movieDomain = MovieDomain();

  @override
  Stream<UpdateMovieScheduleState> mapEventToState(
      UpdateMovieScheduleEvent event) async* {
    if (event is UpdateMovieScheduleEvent) {
      yield* _mapUpdateMovieScheduleToState(event.movieScheduleData);
    }
  }

  Stream<UpdateMovieScheduleState> _mapUpdateMovieScheduleToState(
      MovieScheduleCompanion movieScheduleData) async* {
    try {
      await _movieDomain.updateMovieSchedule(movieScheduleData);
      yield UpdateMovieScheduleSuccessState(message: 'Success');
    } catch (e) {
      yield UpdateMovieScheduleErrorState(message: e.toString());
    }
  }
}
