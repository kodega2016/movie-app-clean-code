import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app_clean_code/src/presentation/blocs/movie_backdrop/movie_backdrop_event.dart';
import 'package:movie_app_clean_code/src/presentation/blocs/movie_backdrop/movie_backdrop_state.dart';

class MovieBackdropBloc extends Bloc<MovieBackdropEvent, MovieBackdropState> {
  MovieBackdropBloc() : super(MovieBackdropInitial()) {
    on<ChangeMovieBackdrop>(_onChangeMovieBackdrop);
  }

  FutureOr<void> _onChangeMovieBackdrop(
      ChangeMovieBackdrop event, Emitter<MovieBackdropState> emit) {
    emit(MovieBackdropLoaded(movie: event.movie));
  }
}
