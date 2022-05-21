import 'package:equatable/equatable.dart';
import 'package:movie_app_clean_code/src/domain/entities/language_entity.dart';

abstract class LanguageEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ChangeLanguage extends LanguageEvent {
  final LanguageEntity language;

  ChangeLanguage({required this.language});

  @override
  List<Object> get props => [language.code];
}
