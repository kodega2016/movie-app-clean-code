import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app_clean_code/src/di/di.dart';
import 'package:movie_app_clean_code/src/presentation/blocs/cast/cast_bloc.dart';
import 'package:movie_app_clean_code/src/presentation/blocs/movie_detail/movie_detail_bloc.dart';
import 'package:movie_app_clean_code/src/presentation/blocs/movie_detail/movie_detail_event.dart';
import 'package:movie_app_clean_code/src/presentation/blocs/movie_detail/movie_detail_state.dart';
import 'package:movie_app_clean_code/src/presentation/blocs/videos/videos_bloc.dart';
import 'package:movie_app_clean_code/src/presentation/blocs/videos/videos_state.dart';
import 'package:movie_app_clean_code/src/presentation/screens/movie_detail/big_poster.dart';
import 'package:movie_app_clean_code/src/presentation/screens/movie_detail/movie_cast_widget.dart';
import 'package:movie_app_clean_code/src/presentation/screens/movie_detail/movie_detail_arguments.dart';
import 'package:movie_app_clean_code/src/presentation/screens/watch_video/watch_video.dart';
import 'package:movie_app_clean_code/src/presentation/screens/watch_video/watch_video_arguments.dart';
import 'package:movie_app_clean_code/src/presentation/widgets/p_button.dart';

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
  late CastBloc _castBloc;
  late VideosBloc _videosBloc;

  @override
  void initState() {
    _movieDetailBloc = getIt<MovieDetailBloc>();
    _castBloc = _movieDetailBloc.castBloc;
    _videosBloc = _movieDetailBloc.videosBloc;
    _movieDetailBloc.add(LoadMovieDetail(id: widget.movieDetailArguments.id));
    super.initState();
  }

  @override
  void dispose() {
    _movieDetailBloc.close();
    _castBloc.close();
    _videosBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocProvider(
        providers: [
          BlocProvider<MovieDetailBloc>.value(value: _movieDetailBloc),
          BlocProvider<CastBloc>.value(value: _castBloc),
          BlocProvider<VideosBloc>.value(value: _videosBloc),
        ],
        child: BlocBuilder<MovieDetailBloc, MovieDetailState>(
          bloc: _movieDetailBloc,
          builder: (context, state) {
            if (state is MovieDetailLoaded) {
              final movie = state.movieDetail;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BigPoster(movie: state.movieDetail),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      movie.overview,
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      'Casts',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                  CastWidget(id: movie.id),
                  const SizedBox(height: 20),
                  VideosWidget(videosBloc: _videosBloc),
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

class VideosWidget extends StatelessWidget {
  const VideosWidget({
    Key? key,
    required this.videosBloc,
  }) : super(key: key);
  final VideosBloc videosBloc;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: videosBloc,
      builder: (context, state) {
        if (state is VideosLoaded) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SizedBox(
              height: 45,
              width: double.infinity,
              child: PButton(
                label: 'Watch Trailer',
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) {
                    return WatchVideo(
                        watchVideoArguments: WatchVideoArguments(state.videos));
                  }));
                },
              ),
            ),
          );
        } else if (state is VideosLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is VideosError) {
          return Text(state.errorType.toString());
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
