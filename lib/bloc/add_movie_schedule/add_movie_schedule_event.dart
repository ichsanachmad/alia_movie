import 'package:alia_movie/data/local/local_repository.dart';
import 'package:equatable/equatable.dart';

class AddMovieScheduleEvent extends Equatable {
  final MovieScheduleCompanion movieScheduleData;

  AddMovieScheduleEvent({required this.movieScheduleData});

  @override
  List<Object?> get props => [this.movieScheduleData];
}
