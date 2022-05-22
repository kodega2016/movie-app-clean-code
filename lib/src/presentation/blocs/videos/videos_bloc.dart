import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app_clean_code/src/domain/entities/movies_params.dart';
import 'package:movie_app_clean_code/src/domain/usecases/get_videos.dart';
import 'package:movie_app_clean_code/src/presentation/blocs/videos/videos_event.dart';
import 'package:movie_app_clean_code/src/presentation/blocs/videos/videos_state.dart';

class VideosBloc extends Bloc<VideosEvent, VideosState> {
  final GetVideos getVideos;
  VideosBloc({required this.getVideos}) : super(VideosInitial()) {
    on<LoadVideos>(_onLoadVideos);
  }

  FutureOr<void> _onLoadVideos(
      LoadVideos event, Emitter<VideosState> emit) async {
    emit(VideosLoading());
    final errorOrVideos = await getVideos.call(MovieParams(id: event.id));
    return errorOrVideos.fold(
      (error) => emit(VideosError(errorType: error.errorType)),
      (videos) => emit(VideosLoaded(videos: videos)),
    );
  }
}
