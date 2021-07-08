import 'package:equatable/equatable.dart';

class GetMovieScheduleDetailEvent extends Equatable {
  final int id;

  GetMovieScheduleDetailEvent({required this.id});

  @override
  List<Object?> get props => [this.id];
}
