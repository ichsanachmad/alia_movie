import 'package:alia_movie/bloc/delete_movie_schedule/delete_movie_schedule_event.dart';
import 'package:alia_movie/bloc/delete_movie_schedule/delete_movie_schedule_state.dart';
import 'package:alia_movie/data/local/local_repository.dart';
import 'package:alia_movie/domain/movie_domain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DeleteMovieScheduleBloc
    extends Bloc<DeleteMovieScheduleEvent, DeleteMovieScheduleState> {
  DeleteMovieScheduleBloc() : super(DeleteMovieScheduleState());
  MovieDomain _movieDomain = MovieDomain();

  @override
  Stream<DeleteMovieScheduleState> mapEventToState(
      DeleteMovieScheduleEvent event) async* {
    if (event is DeleteMovieScheduleEvent) {
      yield* _mapMovieHeaderToState(event.movieScheduleData);
    }
  }

  Stream<DeleteMovieScheduleState> _mapMovieHeaderToState(
      MovieScheduleCompanion movieScheduleData) async* {
    try {
      await _movieDomain.deleteMovieSchedule(movieScheduleData);
      yield DeleteMovieScheduleSuccessState(message: 'Success');
    } catch (e) {
      yield DeleteMovieScheduleErrorState(message: e.toString());
    }
  }
}
