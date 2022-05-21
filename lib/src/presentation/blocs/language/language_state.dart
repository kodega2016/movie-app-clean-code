import 'package:equatable/equatable.dart';
import 'package:movie_app_clean_code/src/domain/entities/language_entity.dart';

abstract class LanguageState extends Equatable {
  @override
  List<Object> get props => [];
}

class LanguageInitial extends LanguageState {}

class LanguageLoaded extends LanguageState {
  final LanguageEntity language;

  LanguageLoaded({required this.language});

  @override
  List<Object> get props => [language.code];
}
