import 'package:alia_movie/data/local/local_repository.dart';
import 'package:equatable/equatable.dart';

class GetMovieScheduleStreamEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class OnGetMovieScheduleStreamEvent extends GetMovieScheduleStreamEvent {
  @override
  List<Object?> get props => [];
}

class GetMovieScheduleStreamUpdateEvent extends GetMovieScheduleStreamEvent {
  final List<MovieScheduleData> movies;

  GetMovieScheduleStreamUpdateEvent({required this.movies});

  @override
  List<Object?> get props => [this.movies];
}
