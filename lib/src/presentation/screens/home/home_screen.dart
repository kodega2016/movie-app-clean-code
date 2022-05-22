import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app_clean_code/src/di/di.dart';
import 'package:movie_app_clean_code/src/presentation/blocs/movie_backdrop/movie_backdrop_bloc.dart';
import 'package:movie_app_clean_code/src/presentation/blocs/movie_carousel/movie_carousel_bloc.dart';
import 'package:movie_app_clean_code/src/presentation/blocs/movie_carousel/movie_carousel_event.dart';
import 'package:movie_app_clean_code/src/presentation/blocs/movie_carousel/movie_carousel_state.dart';
import 'package:movie_app_clean_code/src/presentation/blocs/movie_tabbed/movie_tabbed_bloc.dart';
import 'package:movie_app_clean_code/src/presentation/blocs/movie_tabbed/movie_tabbed_event.dart';
import 'package:movie_app_clean_code/src/presentation/screens/drawer/movie_drawer.dart';
import 'package:movie_app_clean_code/src/presentation/screens/home/movie_carousel/movie_carousel.dart';
import 'package:movie_app_clean_code/src/presentation/widgets/error_widget.dart';

import 'movie_tabbed/movied_tabbed.dart';

class MovieScreen extends StatefulWidget {
  const MovieScreen({Key? key}) : super(key: key);

  @override
  State<MovieScreen> createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {
  late MovieCarouselBloc _movieCarouselBloc;
  late MovieBackdropBloc _movieBackdropBloc;
  late MovieTabbedBloc _movieTabbedBloc;

  @override
  void initState() {
    _movieCarouselBloc = getIt<MovieCarouselBloc>();
    _movieBackdropBloc = _movieCarouselBloc.movieBackdropBloc;
    _movieTabbedBloc = getIt<MovieTabbedBloc>();
    _movieCarouselBloc.add(LoadMovieCarousel(currentIndex: 0));
    _movieTabbedBloc.add(ChangeMovieTab(index: 0));
    super.initState();
  }

  @override
  void dispose() {
    _movieCarouselBloc.close();
    _movieBackdropBloc.close();
    _movieTabbedBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocProvider(
        providers: [
          BlocProvider<MovieCarouselBloc>.value(value: _movieCarouselBloc),
          BlocProvider<MovieBackdropBloc>.value(value: _movieBackdropBloc),
          BlocProvider<MovieTabbedBloc>.value(value: _movieTabbedBloc),
        ],
        child: BlocBuilder<MovieCarouselBloc, MovieCarouselState>(
          builder: (context, state) {
            if (state is MovieCarouselLoaded) {
              return Scaffold(
                drawer: const MovieDrawer(),
                body: Stack(
                  fit: StackFit.expand,
                  children: [
                    FractionallySizedBox(
                      alignment: Alignment.topCenter,
                      heightFactor: 0.4,
                      child: MovieCarousel(
                        currentIndex: state.currentIndex,
                        movies: state.movies,
                      ),
                    ),
                    const FractionallySizedBox(
                      heightFactor: 0.6,
                      alignment: Alignment.bottomCenter,
                      child: MovieTabbed(),
                    ),
                  ],
                ),
              );
            } else if (state is MovieCarouselError) {
              return PErrorWidget(
                  errorType: state.errorType,
                  onPressed: () {
                    _movieCarouselBloc.add(LoadMovieCarousel(currentIndex: 0));
                  });
            } else if (state is MovieCarouselLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}
