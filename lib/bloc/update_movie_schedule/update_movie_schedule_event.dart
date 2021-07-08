import 'package:alia_movie/data/local/local_repository.dart';
import 'package:equatable/equatable.dart';

class UpdateMovieScheduleEvent extends Equatable {
  final MovieScheduleCompanion movieScheduleData;

  UpdateMovieScheduleEvent({required this.movieScheduleData});

  @override
  List<Object?> get props => [this.movieScheduleData];
}
