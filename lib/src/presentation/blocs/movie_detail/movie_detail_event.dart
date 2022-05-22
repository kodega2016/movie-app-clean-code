import 'package:equatable/equatable.dart';

abstract class MovieDetailEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadMovieDetail extends MovieDetailEvent {
  final int id;

  LoadMovieDetail({required this.id});

  @override
  List<Object?> get props => [id];
}
