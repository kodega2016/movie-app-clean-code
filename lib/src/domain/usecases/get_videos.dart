import 'package:dartz/dartz.dart';
import 'package:movie_app_clean_code/src/domain/entities/app_error.dart';
import 'package:movie_app_clean_code/src/domain/entities/movies_params.dart';
import 'package:movie_app_clean_code/src/domain/entities/video_entity.dart';
import 'package:movie_app_clean_code/src/domain/repositories/movie_repository.dart';
import 'package:movie_app_clean_code/src/domain/usecases/usecase.dart';

class GetVideos extends UseCase<List<VideoEntity>, MovieParams> {
  final MovieRepository movieRepository;

  GetVideos({required this.movieRepository});

  @override
  Future<Either<AppError, List<VideoEntity>>> call(MovieParams params) async {
    return movieRepository.getVideos(params.id);
  }
}
