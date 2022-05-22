import 'package:dartz/dartz.dart';
import 'package:movie_app_clean_code/src/domain/entities/app_error.dart';
import 'package:movie_app_clean_code/src/domain/entities/movie_detail_entity.dart';
import 'package:movie_app_clean_code/src/domain/entities/movies_params.dart';
import 'package:movie_app_clean_code/src/domain/repositories/movie_repository.dart';
import 'package:movie_app_clean_code/src/domain/usecases/usecase.dart';

class GetMovieDetail extends UseCase<MovieDetailEntity, MovieParams> {
  final MovieRepository movieRepository;

  GetMovieDetail({required this.movieRepository});

  @override
  Future<Either<AppError, MovieDetailEntity>> call(MovieParams params) async {
    return await movieRepository.getMovieDetail(params.id);
  }
}
