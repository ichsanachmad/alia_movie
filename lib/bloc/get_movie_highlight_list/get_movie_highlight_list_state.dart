import 'package:alia_movie/data/model/model.dart';
import 'package:equatable/equatable.dart';

class GetMovieHighlightListState extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetMovieHighlightListLoadingState extends GetMovieHighlightListState {}

class GetMovieHighlightListUpdateListState extends GetMovieHighlightListState {
  final List<Movie> movies;
  final bool hasReachedMax;

  GetMovieHighlightListUpdateListState(
      {required this.movies, required this.hasReachedMax});

  @override
  List<Object?> get props => [this.movies, this.hasReachedMax];

  GetMovieHighlightListUpdateListState copyWith({
    List<Movie>? movies,
    bool? hasReachedMax,
  }) {
    return GetMovieHighlightListUpdateListState(
        movies: movies ?? this.movies,
        hasReachedMax: hasReachedMax ?? this.hasReachedMax);
  }
}

class GetMovieHighlightListErrorState extends GetMovieHighlightListState {
  final String message;

  GetMovieHighlightListErrorState({required this.message});

  @override
  List<Object?> get props => [this.message];
}
