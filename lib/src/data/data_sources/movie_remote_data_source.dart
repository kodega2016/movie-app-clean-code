import 'package:movie_app_clean_code/src/data/core/api_client.dart';
import 'package:movie_app_clean_code/src/data/core/api_path.dart';
import 'package:movie_app_clean_code/src/data/models/cast_model.dart';
import 'package:movie_app_clean_code/src/data/models/movie_detail_model.dart';
import 'package:movie_app_clean_code/src/data/models/movie_model.dart';
import 'package:movie_app_clean_code/src/data/models/video_model.dart';

abstract class MovieRemoteDataSource {
  Future<List<MovieModel>> getTrending();
  Future<List<MovieModel>> getCommingSoon();
  Future<List<MovieModel>> getPopular();
  Future<List<MovieModel>> getNowPlaying();
  Future<MovieDetailModel> getMovieDetail(int id);
  Future<List<CastModel>> getCaseCrew(int id);
  Future<List<VideoModel>> getVideos(int id);
}

class MovieRemoteDataSourceImpl implements MovieRemoteDataSource {
  final ApiClient apiClient;

  MovieRemoteDataSourceImpl({
    required this.apiClient,
  });

  @override
  Future<List<MovieModel>> getCommingSoon() async {
    final data = await apiClient.get(ApiPath.commingSoon);
    return data['results']
        .map<MovieModel>((doc) => MovieModel.fromJson(doc))
        .toList();
  }

  @override
  Future<List<MovieModel>> getNowPlaying() async {
    final data = await apiClient.get(ApiPath.nowPlaying);

    return data['results']
        .map<MovieModel>((doc) => MovieModel.fromJson(doc))
        .toList();
  }

  @override
  Future<List<MovieModel>> getPopular() async {
    final data = await apiClient.get(ApiPath.popular);
    return data['results']
        .map<MovieModel>((doc) => MovieModel.fromJson(doc))
        .toList();
  }

  @override
  Future<List<MovieModel>> getTrending() async {
    final data = await apiClient.get(ApiPath.trending);
    return data['results']
        .map<MovieModel>((doc) => MovieModel.fromJson(doc))
        .toList();
  }

  @override
  Future<MovieDetailModel> getMovieDetail(int id) async {
    final data = await apiClient.get('${ApiPath.movieDetail}/$id');
    return MovieDetailModel.fromJson(data);
  }

  @override
  Future<List<CastModel>> getCaseCrew(int id) async {
    final data = await apiClient.get('${ApiPath.movieDetail}/$id/credits');

    return data['cast']
        .map<CastModel>((doc) => CastModel.fromJson(doc))
        .toList();
  }

  @override
  Future<List<VideoModel>> getVideos(int id) async {
    final data = await apiClient.get('${ApiPath.movieDetail}/$id/videos');

    return data['results']
        .map<VideoModel>((doc) => VideoModel.fromJson(doc))
        .toList();
  }
}
