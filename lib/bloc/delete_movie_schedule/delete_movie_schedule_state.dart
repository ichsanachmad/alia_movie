import 'package:equatable/equatable.dart';

class DeleteMovieScheduleState extends Equatable {
  @override
  List<Object?> get props => [];
}

class DeleteMovieScheduleLoadingState extends DeleteMovieScheduleState {}

class DeleteMovieScheduleSuccessState extends DeleteMovieScheduleState {
  final String message;

  DeleteMovieScheduleSuccessState({required this.message});

  @override
  List<Object?> get props => [this.message];
}

class DeleteMovieScheduleErrorState extends DeleteMovieScheduleState {
  final String message;

  DeleteMovieScheduleErrorState({required this.message});

  @override
  List<Object?> get props => [this.message];
}
