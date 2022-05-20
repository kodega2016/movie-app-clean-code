import 'package:equatable/equatable.dart';
import 'package:movie_app_clean_code/src/domain/entities/movie_entity.dart';

abstract class MovieBackdropEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ChangeMovieBackdrop extends MovieBackdropEvent {
  final MovieEntity movie;

  ChangeMovieBackdrop({required this.movie});

  @override
  List<Object> get props => [movie];
}
