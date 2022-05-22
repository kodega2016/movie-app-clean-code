import 'package:equatable/equatable.dart';
import 'package:movie_app_clean_code/src/domain/entities/app_error.dart';
import 'package:movie_app_clean_code/src/domain/entities/cast_entity.dart';

abstract class CastState extends Equatable {
  @override
  List<Object> get props => [];
}

class CastInitial extends CastState {}

class CastLoading extends CastState {}

class CastLoaded extends CastState {
  final List<CastEntity> casts;

  CastLoaded({required this.casts});

  @override
  List<Object> get props => [casts];
}

class CastError extends CastState {
  final ErrorType errorType;

  CastError({required this.errorType});

  @override
  List<Object> get props => [errorType];
}
