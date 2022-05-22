import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:movie_app_clean_code/src/data/data_sources/movie_remote_data_source.dart';
import 'package:movie_app_clean_code/src/domain/entities/app_error.dart';
import 'package:movie_app_clean_code/src/domain/entities/movie_detail_entity.dart';
import 'package:movie_app_clean_code/src/domain/entities/movie_entity.dart';
import 'package:movie_app_clean_code/src/domain/repositories/movie_repository.dart';

class MovieRepositoryImpl implements MovieRepository {
  final MovieRemoteDataSource movieRemoteDataSource;

  MovieRepositoryImpl({required this.movieRemoteDataSource});

  @override
  Future<Either<AppError, List<MovieEntity>>> getCommingSoon() async {
    try {
      final movies = await movieRemoteDataSource.getCommingSoon();
      return Right(movies);
    } on SocketException {
      return const Left(AppError(errorType: ErrorType.api));
    } catch (e) {
      return const Left(AppError(errorType: ErrorType.network));
    }
  }

  @override
  Future<Either<AppError, List<MovieEntity>>> getNowPlaying() async {
    try {
      final movies = await movieRemoteDataSource.getNowPlaying();
      return Right(movies);
    } on SocketException {
      return const Left(AppError(errorType: ErrorType.api));
    } catch (e) {
      return const Left(AppError(errorType: ErrorType.network));
    }
  }

  @override
  Future<Either<AppError, List<MovieEntity>>> getPopular() async {
    try {
      final movies = await movieRemoteDataSource.getPopular();
      return Right(movies);
    } on SocketException {
      return const Left(AppError(errorType: ErrorType.api));
    } catch (e) {
      return const Left(AppError(errorType: ErrorType.network));
    }
  }

  @override
  Future<Either<AppError, List<MovieEntity>>> getTrending() async {
    try {
      final movies = await movieRemoteDataSource.getTrending();
      return Right(movies);
    } on SocketException {
      return const Left(AppError(errorType: ErrorType.api));
    } catch (e) {
      return const Left(AppError(errorType: ErrorType.network));
    }
  }

  @override
  Future<Either<AppError, MovieDetailEntity>> getMovieDetail(int id) async {
    try {
      final result = await movieRemoteDataSource.getMovieDetail(id);
      return Right(result);
    } on SocketException {
      return const Left(AppError(errorType: ErrorType.network));
    } catch (e) {
      return const Left(AppError(errorType: ErrorType.api));
    }
  }
}
