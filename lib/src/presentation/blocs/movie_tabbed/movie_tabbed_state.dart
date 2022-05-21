import 'package:equatable/equatable.dart';
import 'package:movie_app_clean_code/src/domain/entities/app_error.dart';
import 'package:movie_app_clean_code/src/domain/entities/movie_entity.dart';

abstract class MovieTabbedState extends Equatable {
  final int currentIndex;

  const MovieTabbedState({required this.currentIndex});

  @override
  List<Object> get props => [currentIndex];
}

class MovieTabbedInitial extends MovieTabbedState {
  const MovieTabbedInitial() : super(currentIndex: 0);
}

class MovieTabbedLoading extends MovieTabbedState {
  const MovieTabbedLoading({required int currentIndex})
      : super(currentIndex: currentIndex);
}

class MovieTabbedLoaded extends MovieTabbedState {
  final List<MovieEntity> movies;

  const MovieTabbedLoaded({
    required int currentIndex,
    required this.movies,
  }) : super(currentIndex: currentIndex);

  @override
  List<Object> get props => [currentIndex, movies];
}

class MovieTabbedError extends MovieTabbedState {
  final ErrorType errorType;

  const MovieTabbedError({required this.errorType, required int currentIndex})
      : super(currentIndex: currentIndex);

  @override
  List<Object> get props => [errorType, currentIndex];
}
