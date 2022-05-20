import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app_clean_code/src/data/core/api_constants.dart';
import 'package:movie_app_clean_code/src/domain/entities/movie_entity.dart';
import 'package:movie_app_clean_code/src/presentation/blocs/movie_backdrop/movie_backdrop_bloc.dart';
import 'package:movie_app_clean_code/src/presentation/blocs/movie_backdrop/movie_backdrop_state.dart';
import 'package:movie_app_clean_code/src/presentation/screens/home/movie_carousel/movie_carousel_page_view.dart';
import 'package:movie_app_clean_code/src/presentation/widgets/movie_app_bar.dart';

class MovieCarousel extends StatelessWidget {
  const MovieCarousel({
    Key? key,
    required this.currentIndex,
    required this.movies,
  }) : super(key: key);

  final List<MovieEntity> movies;
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const MovieBackdrop(),
        Column(
          children: [
            const SizedBox(height: 32),
            const MovieAppBar(),
            MovieCarouselPageView(
              movies: movies,
              currentScreen: currentIndex,
            ),
          ],
        ),
      ],
    );
  }
}

class MovieBackdrop extends StatelessWidget {
  const MovieBackdrop({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieBackdropBloc, MovieBackdropState>(
        builder: (context, state) {
      if (state is MovieBackdropLoaded) {
        return FractionallySizedBox(
          heightFactor: 0.6,
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Image.network(
                '${ApiConstants.imageUrl}${state.movie.posterPath}',
                fit: BoxFit.cover,
              ),
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 1,
                  color: Colors.transparent,
                ),
              ),
            ],
          ),
        );
      } else {
        return const SizedBox.shrink();
      }
    });
  }
}
