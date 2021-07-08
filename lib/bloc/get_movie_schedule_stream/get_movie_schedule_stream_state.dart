import 'package:alia_movie/data/local/local_repository.dart';
import 'package:equatable/equatable.dart';

class GetMovieScheduleStreamState extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetMovieScheduleStreamInitState extends GetMovieScheduleStreamState {}

class GetMovieScheduleStreamLoadingState extends GetMovieScheduleStreamState {}

class GetMovieScheduleStreamSuccessState extends GetMovieScheduleStreamState {
  final List<MovieScheduleData> movies;

  GetMovieScheduleStreamSuccessState({required this.movies});

  @override
  List<Object?> get props => [this.movies];
}

class GetMovieScheduleStreamErrorState extends GetMovieScheduleStreamState {
  final String message;

  GetMovieScheduleStreamErrorState({required this.message});

  @override
  List<Object?> get props => [this.message];
}
