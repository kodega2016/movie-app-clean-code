import 'package:equatable/equatable.dart';

abstract class CastEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadCast extends CastEvent {
  final int id;

  LoadCast({required this.id});

  @override
  List<Object> get props => [id];
}
