import 'package:equatable/equatable.dart';

class UpdateMovieScheduleState extends Equatable {
  @override
  List<Object?> get props => [];
}

class UpdateMovieScheduleLoadingState extends UpdateMovieScheduleState {}

class UpdateMovieScheduleSuccessState extends UpdateMovieScheduleState {
  final String message;

  UpdateMovieScheduleSuccessState({required this.message});

  @override
  List<Object?> get props => [this.message];
}

class UpdateMovieScheduleErrorState extends UpdateMovieScheduleState {
  final String message;

  UpdateMovieScheduleErrorState({required this.message});

  @override
  List<Object?> get props => [this.message];
}
