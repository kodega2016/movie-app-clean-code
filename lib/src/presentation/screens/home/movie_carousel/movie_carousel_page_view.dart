import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app_clean_code/src/domain/entities/movie_entity.dart';
import 'package:movie_app_clean_code/src/presentation/blocs/movie_backdrop/movie_backdrop_bloc.dart';
import 'package:movie_app_clean_code/src/presentation/blocs/movie_backdrop/movie_backdrop_event.dart';
import 'package:movie_app_clean_code/src/presentation/screens/home/movie_carousel/movie_carousel_card.dart';

class MovieCarouselPageView extends StatefulWidget {
  const MovieCarouselPageView({
    Key? key,
    required this.movies,
    required this.currentScreen,
  }) : super(key: key);

  final List<MovieEntity> movies;
  final int currentScreen;

  @override
  State<MovieCarouselPageView> createState() => _MovieCarouselPageViewState();
}

class _MovieCarouselPageViewState extends State<MovieCarouselPageView> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.3,
      child: PageView.builder(
        itemCount: widget.movies.length,
        onPageChanged: (i) {
          BlocProvider.of<MovieBackdropBloc>(context)
              .add(ChangeMovieBackdrop(movie: widget.movies[i]));
        },
        itemBuilder: (context, i) {
          final movie = widget.movies[i];
          return MovieCarouselCard(
            id: movie.id,
            title: movie.title,
            posterPath: movie.posterPath,
          );
        },
      ),
    );
  }
}
