import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app_clean_code/movie_bloc_observer.dart';
import 'package:movie_app_clean_code/src/presentation/movie_app.dart';

import 'src/di/di.dart' as di;

void main() async {
  BlocOverrides.runZoned(() async {
    di.init();

    runApp(const MovieApp());
  }, blocObserver: MovieBlocObserver());
}
