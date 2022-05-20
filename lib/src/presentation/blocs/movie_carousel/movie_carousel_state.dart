import 'package:equatable/equatable.dart';
import 'package:movie_app_clean_code/src/domain/entities/app_error.dart';
import 'package:movie_app_clean_code/src/domain/entities/movie_entity.dart';

abstract class MovieCarouselState extends Equatable {
  @override
  List<Object> get props => [];
}

class MovieCarouselInitial extends MovieCarouselState {}

class MovieCarouselLoading extends MovieCarouselState {}

class MovieCarouselLoaded extends MovieCarouselState {
  final List<MovieEntity> movies;
  final int currentIndex;

  MovieCarouselLoaded({required this.movies, this.currentIndex = 0});

  @override
  List<Object> get props => [movies, currentIndex];
}

class MovieCarouselError extends MovieCarouselState {
  final ErrorType errorType;

  MovieCarouselError({required this.errorType});

  @override
  List<Object> get props => [errorType];
}
