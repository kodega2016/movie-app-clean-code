import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app_clean_code/src/di/di.dart';
import 'package:movie_app_clean_code/src/presentation/blocs/movie_detail/movie_detail_bloc.dart';
import 'package:movie_app_clean_code/src/presentation/blocs/movie_detail/movie_detail_event.dart';
import 'package:movie_app_clean_code/src/presentation/blocs/movie_detail/movie_detail_state.dart';
import 'package:movie_app_clean_code/src/presentation/screens/movie_detail/big_poster.dart';
import 'package:movie_app_clean_code/src/presentation/screens/movie_detail/movie_detail_arguments.dart';

class MovieDetail extends StatefulWidget {
  const MovieDetail({
    Key? key,
    required this.movieDetailArguments,
  }) : super(key: key);

  final MovieDetailArguments movieDetailArguments;

  @override
  State<MovieDetail> createState() => _MovieDetailState();
}

class _MovieDetailState extends State<MovieDetail> {
  late MovieDetailBloc _movieDetailBloc;

  @override
  void initState() {
    _movieDetailBloc = getIt<MovieDetailBloc>();
    _movieDetailBloc.add(LoadMovieDetail(id: widget.movieDetailArguments.id));
    super.initState();
  }

  @override
  void dispose() {
    _movieDetailBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<MovieDetailBloc>.value(
        value: _movieDetailBloc,
        child: BlocBuilder<MovieDetailBloc, MovieDetailState>(
          bloc: _movieDetailBloc,
          builder: (context, state) {
            if (state is MovieDetailLoaded) {
              final movie = state.movieDetail;
              return Column(
                children: [
                  BigPoster(movie: state.movieDetail),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      movie.overview,
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                  ),
                ],
              );
            } else if (state is MovieDetailError) {
            } else if (state is MovieDetailLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
