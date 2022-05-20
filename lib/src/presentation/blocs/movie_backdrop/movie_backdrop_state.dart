import 'package:equatable/equatable.dart';
import 'package:movie_app_clean_code/src/domain/entities/movie_entity.dart';

abstract class MovieBackdropState extends Equatable {
  @override
  List<Object> get props => [];
}

class MovieBackdropInitial extends MovieBackdropState {}

class MovieBackdropLoaded extends MovieBackdropState {
  final MovieEntity movie;

  MovieBackdropLoaded({required this.movie});

  @override
  List<Object> get props => [movie];
}
