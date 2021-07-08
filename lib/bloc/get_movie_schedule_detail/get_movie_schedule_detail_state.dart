import 'package:alia_movie/data/local/local_repository.dart';
import 'package:equatable/equatable.dart';

class GetMovieScheduleDetailState extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetMovieScheduleDetailLoadingState extends GetMovieScheduleDetailState {}

class GetMovieScheduleDetailSuccessState extends GetMovieScheduleDetailState {
  final List<MovieScheduleData> movies;

  GetMovieScheduleDetailSuccessState({required this.movies});

  @override
  List<Object?> get props => [this.movies];
}

class GetMovieScheduleDetailErrorState extends GetMovieScheduleDetailState {
  final String message;

  GetMovieScheduleDetailErrorState({required this.message});

  @override
  List<Object?> get props => [this.message];
}
