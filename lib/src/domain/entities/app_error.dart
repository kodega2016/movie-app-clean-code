import 'package:equatable/equatable.dart';

enum ErrorType { api, network }

class AppError extends Equatable {
  final ErrorType errorType;

  const AppError({required this.errorType});

  @override
  List<Object> get props => [errorType];
}
