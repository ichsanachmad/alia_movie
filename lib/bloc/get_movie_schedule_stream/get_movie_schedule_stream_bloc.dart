import 'dart:async';

import 'package:alia_movie/bloc/get_movie_schedule_stream/get_movie_schedule_stream_event.dart';
import 'package:alia_movie/bloc/get_movie_schedule_stream/get_movie_schedule_stream_state.dart';
import 'package:alia_movie/data/local/local_repository.dart';
import 'package:alia_movie/domain/movie_domain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GetMovieScheduleStreamBloc
    extends Bloc<GetMovieScheduleStreamEvent, GetMovieScheduleStreamState> {
  MovieDomain _movieDomain = MovieDomain();
  StreamSubscription? _subscription;

  GetMovieScheduleStreamBloc() : super(GetMovieScheduleStreamInitState());

  @override
  Stream<GetMovieScheduleStreamState> mapEventToState(
      GetMovieScheduleStreamEvent event) async* {
    if (event is OnGetMovieScheduleStreamEvent) {
      _getMovieScheduleStream();
    }
    if (event is GetMovieScheduleStreamUpdateEvent) {
      yield* _mapMovieScheduleToState(event.movies);
    }
  }

  void _getMovieScheduleStream() async {
    _subscription?.cancel();
    _subscription = _movieDomain.watchMovieSchedule().listen((event) {
      add(GetMovieScheduleStreamUpdateEvent(movies: event));
    });
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }

  Stream<GetMovieScheduleStreamState> _mapMovieScheduleToState(
      List<MovieScheduleData> movies) async* {
    try {
      yield GetMovieScheduleStreamSuccessState(movies: movies);
    } catch (e) {
      yield GetMovieScheduleStreamErrorState(message: e.toString());
    }
  }
}
