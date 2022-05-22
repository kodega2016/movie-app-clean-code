import 'package:dartz/dartz.dart';
import 'package:movie_app_clean_code/src/domain/entities/app_error.dart';
import 'package:movie_app_clean_code/src/domain/entities/cast_entity.dart';
import 'package:movie_app_clean_code/src/domain/entities/movies_params.dart';
import 'package:movie_app_clean_code/src/domain/repositories/movie_repository.dart';
import 'package:movie_app_clean_code/src/domain/usecases/usecase.dart';

class GetCast extends UseCase<List<CastEntity>, MovieParams> {
  final MovieRepository movieRepository;

  GetCast({required this.movieRepository});

  @override
  Future<Either<AppError, List<CastEntity>>> call(MovieParams params) async {
    return await movieRepository.getCastCrew(params.id);
  }
}
