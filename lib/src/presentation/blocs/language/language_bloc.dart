import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app_clean_code/src/presentation/blocs/language/language_event.dart';
import 'package:movie_app_clean_code/src/presentation/blocs/language/language_state.dart';

class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  LanguageBloc() : super(LanguageInitial()) {
    on<ChangeLanguage>(_onChangeLanguage);
  }

  FutureOr<void> _onChangeLanguage(
      ChangeLanguage event, Emitter<LanguageState> emit) {
    emit(LanguageLoaded(language: event.language));
  }
}
