import 'package:equatable/equatable.dart';

abstract class MovieCarouselEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadMovieCarousel extends MovieCarouselEvent {
  final int currentIndex;

  LoadMovieCarousel({required this.currentIndex});

  @override
  List<Object> get props => [currentIndex];
}
