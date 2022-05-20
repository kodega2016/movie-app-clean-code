import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app_clean_code/src/domain/entities/app_error.dart';
import 'package:movie_app_clean_code/src/domain/entities/movie_entity.dart';
import 'package:movie_app_clean_code/src/domain/usecases/get_comming_soon.dart';
import 'package:movie_app_clean_code/src/domain/usecases/get_now_playing.dart';
import 'package:movie_app_clean_code/src/domain/usecases/get_popular.dart';
import 'package:movie_app_clean_code/src/domain/usecases/no_params.dart';
import 'package:movie_app_clean_code/src/presentation/blocs/movie_tabbed/movie_tabbed_event.dart';
import 'package:movie_app_clean_code/src/presentation/blocs/movie_tabbed/movie_tabbed_state.dart';

class MovieTabbedBloc extends Bloc<MovieTabbedEvent, MovieTabbedState> {
  final GetNowPlaying getNowPlaying;
  final GetPopular getPopular;
  final GetCommingSoon getCommingSoon;

  MovieTabbedBloc({
    required this.getNowPlaying,
    required this.getPopular,
    required this.getCommingSoon,
  }) : super(const MovieTabbedInitial()) {
    on<ChangeMovieTab>(_onChangeMovieTab);
  }

  FutureOr<void> _onChangeMovieTab(
      ChangeMovieTab event, Emitter<MovieTabbedState> emit) async {
    emit(MovieTabbedLoading(currentIndex: event.index));
    late Either<AppError, List<MovieEntity>> eitherErrorOrMovies;

    await Future.delayed(const Duration(seconds: 2));

    switch (event.index) {
      case 0:
        eitherErrorOrMovies = await getNowPlaying.call(NoParams());
        break;
      case 1:
        eitherErrorOrMovies = await getPopular.call(NoParams());
        break;
      case 2:
        eitherErrorOrMovies = await getCommingSoon.call(NoParams());

        break;
      default:
    }

    eitherErrorOrMovies.fold(
      (error) => emit(
        MovieTabbedError(
          errorType: error.errorType,
          currentIndex: state.currentIndex,
        ),
      ),
      (movies) => emit(
        MovieTabbedLoaded(
          currentIndex: event.index,
          movies: movies,
        ),
      ),
    );
  }
}
