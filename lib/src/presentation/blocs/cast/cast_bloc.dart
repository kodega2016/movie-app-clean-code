import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app_clean_code/src/domain/entities/movies_params.dart';
import 'package:movie_app_clean_code/src/domain/usecases/get_cast.dart';
import 'package:movie_app_clean_code/src/presentation/blocs/cast/cast_event.dart';
import 'package:movie_app_clean_code/src/presentation/blocs/cast/cast_state.dart';

class CastBloc extends Bloc<CastEvent, CastState> {
  final GetCast getCast;

  CastBloc({required this.getCast}) : super(CastInitial()) {
    on<LoadCast>(_onLoadCast);
  }

  FutureOr<void> _onLoadCast(LoadCast event, Emitter<CastState> emit) async {
    emit(CastLoading());
    final eitherErrorOrCasts = await getCast.call(MovieParams(id: event.id));
    eitherErrorOrCasts.fold(
      (error) => emit(CastError(errorType: error.errorType)),
      (casts) => emit(CastLoaded(casts: casts)),
    );
  }
}
