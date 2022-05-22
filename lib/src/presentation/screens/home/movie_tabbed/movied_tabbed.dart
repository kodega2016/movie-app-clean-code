import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app_clean_code/src/common/constants/translation_constants.dart';
import 'package:movie_app_clean_code/src/common/extensions/string_extensions.dart';
import 'package:movie_app_clean_code/src/data/core/api_constants.dart';
import 'package:movie_app_clean_code/src/domain/entities/movie_entity.dart';
import 'package:movie_app_clean_code/src/presentation/blocs/movie_tabbed/movie_tabbed_bloc.dart';
import 'package:movie_app_clean_code/src/presentation/blocs/movie_tabbed/movie_tabbed_event.dart';
import 'package:movie_app_clean_code/src/presentation/blocs/movie_tabbed/movie_tabbed_state.dart';
import 'package:movie_app_clean_code/src/presentation/screens/home/movie_tabbed/movie_tabbed_item.dart';
import 'package:movie_app_clean_code/src/presentation/screens/movie_detail/movie_detail.dart';
import 'package:movie_app_clean_code/src/presentation/screens/movie_detail/movie_detail_arguments.dart';
import 'package:movie_app_clean_code/src/presentation/widgets/error_widget.dart';

class MovieTabbed extends StatelessWidget {
  const MovieTabbed({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: BlocBuilder<MovieTabbedBloc, MovieTabbedState>(
          builder: (context, state) {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MovieTabbedItem(
                  isSelected: state.currentIndex == 0,
                  onPressed: () {
                    BlocProvider.of<MovieTabbedBloc>(context)
                        .add(ChangeMovieTab(index: 0));
                  },
                  label: TranslationConstants.now.t(context),
                ),
                MovieTabbedItem(
                  isSelected: state.currentIndex == 1,
                  onPressed: () {
                    BlocProvider.of<MovieTabbedBloc>(context)
                        .add(ChangeMovieTab(index: 1));
                  },
                  label: TranslationConstants.popular.t(context),
                ),
                MovieTabbedItem(
                  isSelected: state.currentIndex == 2,
                  onPressed: () {
                    BlocProvider.of<MovieTabbedBloc>(context)
                        .add(ChangeMovieTab(index: 2));
                  },
                  label: TranslationConstants.soon.t(context),
                ),
              ],
            ),
            if (state is MovieTabbedLoaded)
              state.movies.isEmpty
                  ? Expanded(
                      child: Container(
                        alignment: Alignment.center,
                        child: Text(TranslationConstants.noMovies.t(context)),
                      ),
                    )
                  : Flexible(
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: state.movies.length,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 8,
                        ),
                        itemBuilder: (context, i) {
                          final MovieEntity movie = state.movies[i];
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (_) {
                                return MovieDetail(
                                    movieDetailArguments: MovieDetailArguments(
                                  id: movie.id,
                                ));
                              }));
                            },
                            child: Column(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Builder(builder: (context) {
                                      return ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.network(
                                          '${ApiConstants.imageUrl}${movie.posterPath}',
                                        ),
                                      );
                                    }),
                                  ),
                                ),
                                Text(
                                  movie.title.trimToFixedString,
                                  style: Theme.of(context).textTheme.bodyText2,
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
            if (state is MovieTabbedLoading)
              const Expanded(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Center(child: CircularProgressIndicator()),
                ),
              ),
            if (state is MovieTabbedError)
              Expanded(
                child: PErrorWidget(
                    errorType: state.errorType,
                    onPressed: () {
                      BlocProvider.of<MovieTabbedBloc>(context).add(
                        ChangeMovieTab(index: state.currentIndex),
                      );
                    }),
              ),
          ],
        );
      }),
    );
  }
}
