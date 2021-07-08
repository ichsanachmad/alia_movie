import 'package:alia_movie/bloc/add_movie_schedule/add_movie_schedule_event.dart';
import 'package:alia_movie/bloc/add_movie_schedule/add_movie_schedule_state.dart';
import 'package:alia_movie/data/local/local_repository.dart';
import 'package:alia_movie/domain/movie_domain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddMovieScheduleBloc
    extends Bloc<AddMovieScheduleEvent, AddMovieScheduleState> {
  AddMovieScheduleBloc() : super(AddMovieScheduleState());
  MovieDomain _movieDomain = MovieDomain();

  @override
  Stream<AddMovieScheduleState> mapEventToState(
      AddMovieScheduleEvent event) async* {
    if (event is AddMovieScheduleEvent) {
      yield* _mapAddMovieScheduleToState(event.movieScheduleData);
    }
  }

  Stream<AddMovieScheduleState> _mapAddMovieScheduleToState(
      MovieScheduleCompanion movieScheduleData) async* {
    try {
      await _movieDomain.addMovieSchedule(movieScheduleData);
      yield AddMovieScheduleSuccessState(message: 'Success Add Schedule');
    } catch (e) {
      yield AddMovieScheduleErrorState(message: 'Failed Add Schedule');
    }
  }
}
