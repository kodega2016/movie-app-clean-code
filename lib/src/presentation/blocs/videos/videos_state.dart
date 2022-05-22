import 'package:equatable/equatable.dart';
import 'package:movie_app_clean_code/src/domain/entities/app_error.dart';
import 'package:movie_app_clean_code/src/domain/entities/video_entity.dart';

abstract class VideosState extends Equatable {
  @override
  List<Object> get props => [];
}

class VideosInitial extends VideosState {}

class VideosLoading extends VideosState {}

class VideosLoaded extends VideosState {
  final List<VideoEntity> videos;

  VideosLoaded({required this.videos});

  @override
  List<Object> get props => [videos];
}

class VideosError extends VideosState {
  final ErrorType errorType;

  VideosError({required this.errorType});

  @override
  List<Object> get props => [errorType];
}
