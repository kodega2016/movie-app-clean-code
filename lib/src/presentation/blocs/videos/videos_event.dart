import 'package:equatable/equatable.dart';

abstract class VideosEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadVideos extends VideosEvent {
  final int id;

  LoadVideos({required this.id});

  @override
  List<Object> get props => [id];
}
