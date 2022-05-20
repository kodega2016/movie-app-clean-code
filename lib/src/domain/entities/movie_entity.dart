import 'package:equatable/equatable.dart';

class MovieEntity extends Equatable {
  final int id;
  final String title;
  final String posterPath;

  const MovieEntity({
    required this.id,
    required this.title,
    required this.posterPath,
  });

  @override
  List<Object?> get props => [id, title];
}
