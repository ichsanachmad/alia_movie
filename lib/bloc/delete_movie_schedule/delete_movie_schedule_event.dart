import 'package:alia_movie/data/local/local_repository.dart';
import 'package:equatable/equatable.dart';

class DeleteMovieScheduleEvent extends Equatable {
  final MovieScheduleCompanion movieScheduleData;

  DeleteMovieScheduleEvent({required this.movieScheduleData});

  @override
  List<Object?> get props => [this.movieScheduleData];
}
