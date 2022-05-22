import 'package:dartz/dartz.dart';
import 'package:movie_app_clean_code/src/domain/entities/app_error.dart';
import 'package:movie_app_clean_code/src/domain/entities/movie_entity.dart';
import 'package:movie_app_clean_code/src/domain/entities/no_params.dart';
import 'package:movie_app_clean_code/src/domain/repositories/movie_repository.dart';
import 'package:movie_app_clean_code/src/domain/usecases/usecase.dart';

class GetCommingSoon extends UseCase<List<MovieEntity>, NoParams> {
  final MovieRepository movieRepository;

  GetCommingSoon({required this.movieRepository});

  @override
  Future<Either<AppError, List<MovieEntity>>> call(NoParams params) async {
    return await movieRepository.getCommingSoon();
  }
}
