import 'package:movie_app_clean_code/src/data/core/api_client.dart';
import 'package:movie_app_clean_code/src/data/core/api_path.dart';
import 'package:movie_app_clean_code/src/data/models/movie_detail_model.dart';
import 'package:movie_app_clean_code/src/data/models/movie_model.dart';

abstract class MovieRemoteDataSource {
  Future<List<MovieModel>> getTrending();
  Future<List<MovieModel>> getCommingSoon();
  Future<List<MovieModel>> getPopular();
  Future<List<MovieModel>> getNowPlaying();
  Future<MovieDetailModel> getMovieDetail(int id);
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
}
