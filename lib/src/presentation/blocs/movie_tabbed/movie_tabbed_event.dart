import 'package:equatable/equatable.dart';

abstract class MovieTabbedEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ChangeMovieTab extends MovieTabbedEvent {
  final int index;

  ChangeMovieTab({required this.index});

  @override
  List<Object> get props => [index];
}
