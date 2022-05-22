import 'package:equatable/equatable.dart';

class VideoEntity extends Equatable {
  const VideoEntity({
    required this.title,
    required this.type,
    required this.id,
    required this.key,
  });

  final String id;
  final String title;
  final String type;
  final String key;

  @override
  List<Object?> get props => [id];
}
