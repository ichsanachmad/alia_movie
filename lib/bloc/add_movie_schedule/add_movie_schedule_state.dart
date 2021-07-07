import 'package:equatable/equatable.dart';

class AddMovieScheduleState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AddMovieScheduleLoadingState extends AddMovieScheduleState {}

class AddMovieScheduleSuccessState extends AddMovieScheduleState {
  final String message;

  AddMovieScheduleSuccessState({required this.message});

  @override
  List<Object?> get props => [this.message];
}

class AddMovieScheduleErrorState extends AddMovieScheduleState {
  final String message;

  AddMovieScheduleErrorState({required this.message});

  @override
  List<Object?> get props => [this.message];
}
