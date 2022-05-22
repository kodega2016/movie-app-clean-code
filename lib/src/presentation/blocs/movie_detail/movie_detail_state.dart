import 'package:equatable/equatable.dart';
import 'package:movie_app_clean_code/src/domain/entities/app_error.dart';
import 'package:movie_app_clean_code/src/domain/entities/movie_detail_entity.dart';

abstract class MovieDetailState extends Equatable {
  @override
  List<Object> get props => [];
}

class MovieDetailInitial extends MovieDetailState {}

class MovieDetailLoading extends MovieDetailState {}

class MovieDetailLoaded extends MovieDetailState {
  final MovieDetailEntity movieDetail;

  MovieDetailLoaded({required this.movieDetail});

  @override
  List<Object> get props => [movieDetail.id, movieDetail.title];
}

class MovieDetailError extends MovieDetailState {
  final ErrorType errorType;

  MovieDetailError({required this.errorType});
  @override
  List<Object> get props => [errorType];
}
