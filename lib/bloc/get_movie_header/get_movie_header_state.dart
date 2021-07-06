import 'package:alia_movie/data/model/model.dart';
import 'package:equatable/equatable.dart';

class GetMovieHeaderState extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetMovieHeaderLoadingState extends GetMovieHeaderState {}

class GetMovieHeaderSuccessState extends GetMovieHeaderState {
  final Movie movie;

  GetMovieHeaderSuccessState(
      {required this.movie});

  @override
  List<Object?> get props => [this.movie];
}

class GetMovieHeaderErrorState extends GetMovieHeaderState {
  final String message;

  GetMovieHeaderErrorState({required this.message});

  @override
  List<Object?> get props => [this.message];
}
