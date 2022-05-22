import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app_clean_code/src/data/core/api_client.dart';
import 'package:movie_app_clean_code/src/data/data_sources/movie_remote_data_source.dart';
import 'package:movie_app_clean_code/src/data/repositories/movie_repository.dart';
import 'package:movie_app_clean_code/src/domain/repositories/movie_repository.dart';
import 'package:movie_app_clean_code/src/domain/usecases/get_cast.dart';
import 'package:movie_app_clean_code/src/domain/usecases/get_comming_soon.dart';
import 'package:movie_app_clean_code/src/domain/usecases/get_movie_detail.dart';
import 'package:movie_app_clean_code/src/domain/usecases/get_now_playing.dart';
import 'package:movie_app_clean_code/src/domain/usecases/get_popular.dart';
import 'package:movie_app_clean_code/src/domain/usecases/get_trending.dart';
import 'package:movie_app_clean_code/src/domain/usecases/get_videos.dart';
import 'package:movie_app_clean_code/src/presentation/blocs/cast/cast_bloc.dart';
import 'package:movie_app_clean_code/src/presentation/blocs/language/language_bloc.dart';
import 'package:movie_app_clean_code/src/presentation/blocs/movie_backdrop/movie_backdrop_bloc.dart';
import 'package:movie_app_clean_code/src/presentation/blocs/movie_carousel/movie_carousel_bloc.dart';
import 'package:movie_app_clean_code/src/presentation/blocs/movie_detail/movie_detail_bloc.dart';
import 'package:movie_app_clean_code/src/presentation/blocs/movie_tabbed/movie_tabbed_bloc.dart';
import 'package:movie_app_clean_code/src/presentation/blocs/videos/videos_bloc.dart';

final GetIt getIt = GetIt.I;

void init() {
  getIt.registerLazySingleton(() => http.Client());
  getIt.registerLazySingleton(() => ApiClient(client: getIt()));
  getIt.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(apiClient: getIt()));

  getIt.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(movieRemoteDataSource: getIt()),
  );

  getIt.registerLazySingleton(() => GetTrending(movieRepository: getIt()));
  getIt.registerLazySingleton(() => GetCommingSoon(movieRepository: getIt()));
  getIt.registerLazySingleton(() => GetPopular(movieRepository: getIt()));
  getIt.registerLazySingleton(() => GetNowPlaying(movieRepository: getIt()));
  getIt.registerLazySingleton(() => GetMovieDetail(movieRepository: getIt()));
  getIt.registerLazySingleton(() => GetCast(movieRepository: getIt()));
  getIt.registerLazySingleton(() => GetVideos(movieRepository: getIt()));

  getIt.registerFactory<MovieBackdropBloc>(() => MovieBackdropBloc());
  getIt.registerFactory(() => MovieCarouselBloc(
        getPopular: getIt(),
        movieBackdropBloc: getIt(),
      ));

  getIt.registerFactory(
    () => MovieTabbedBloc(
      getNowPlaying: getIt(),
      getPopular: getIt(),
      getCommingSoon: getIt(),
    ),
  );

  getIt.registerSingleton<LanguageBloc>(LanguageBloc());

  getIt.registerFactory(() => MovieDetailBloc(
        castBloc: getIt(),
        videosBloc: getIt(),
        getMovieDetail: getIt(),
      ));
  getIt.registerFactory(() => CastBloc(getCast: getIt()));
  getIt.registerFactory(() => VideosBloc(getVideos: getIt()));
}
