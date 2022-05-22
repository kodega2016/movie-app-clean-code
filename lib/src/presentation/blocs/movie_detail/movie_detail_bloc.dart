import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app_clean_code/src/domain/entities/movies_params.dart';
import 'package:movie_app_clean_code/src/domain/usecases/get_movie_detail.dart';
import 'package:movie_app_clean_code/src/presentation/blocs/cast/cast_bloc.dart';
import 'package:movie_app_clean_code/src/presentation/blocs/cast/cast_event.dart';
import 'package:movie_app_clean_code/src/presentation/blocs/movie_detail/movie_detail_event.dart';
import 'package:movie_app_clean_code/src/presentation/blocs/movie_detail/movie_detail_state.dart';
import 'package:movie_app_clean_code/src/presentation/blocs/videos/videos_bloc.dart';
import 'package:movie_app_clean_code/src/presentation/blocs/videos/videos_event.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  final GetMovieDetail getMovieDetail;
  final CastBloc castBloc;
  final VideosBloc videosBloc;

  MovieDetailBloc({
    required this.castBloc,
    required this.getMovieDetail,
    required this.videosBloc,
  }) : super(MovieDetailInitial()) {
    on<LoadMovieDetail>(_onLoadMovieDetail);
  }

  FutureOr<void> _onLoadMovieDetail(
      LoadMovieDetail event, Emitter<MovieDetailState> emit) async {
    emit(MovieDetailLoading());
    final eitherErrorOrMovieDetail =
        await getMovieDetail.call(MovieParams(id: event.id));
    eitherErrorOrMovieDetail
        .fold((error) => emit(MovieDetailError(errorType: error.errorType)),
            (movieDetail) {
      castBloc.add(LoadCast(id: movieDetail.id));
      videosBloc.add(LoadVideos(id: movieDetail.id));
      emit(MovieDetailLoaded(movieDetail: movieDetail));
    });
  }
}
