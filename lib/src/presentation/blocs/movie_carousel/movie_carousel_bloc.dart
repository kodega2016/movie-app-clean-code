import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app_clean_code/src/domain/entities/no_params.dart';
import 'package:movie_app_clean_code/src/domain/usecases/get_popular.dart';
import 'package:movie_app_clean_code/src/presentation/blocs/movie_backdrop/movie_backdrop_bloc.dart';
import 'package:movie_app_clean_code/src/presentation/blocs/movie_backdrop/movie_backdrop_event.dart';
import 'package:movie_app_clean_code/src/presentation/blocs/movie_carousel/movie_carousel_event.dart';
import 'package:movie_app_clean_code/src/presentation/blocs/movie_carousel/movie_carousel_state.dart';

class MovieCarouselBloc extends Bloc<MovieCarouselEvent, MovieCarouselState> {
  final GetPopular getPopular;
  final MovieBackdropBloc movieBackdropBloc;

  MovieCarouselBloc({
    required this.getPopular,
    required this.movieBackdropBloc,
  }) : super(MovieCarouselInitial()) {
    on(_onLoadMovieCarousel);
  }

  FutureOr<void> _onLoadMovieCarousel(
      MovieCarouselEvent event, Emitter<MovieCarouselState> emit) async {
    emit(MovieCarouselLoading());
    final errorOrMovies = await getPopular.call(NoParams());
    return errorOrMovies
        .fold((error) => emit(MovieCarouselError(errorType: error.errorType)),
            (movies) {
      movieBackdropBloc.add(ChangeMovieBackdrop(movie: movies.first));
      emit(MovieCarouselLoaded(movies: movies));
    });
  }
}
