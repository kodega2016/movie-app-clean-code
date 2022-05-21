import 'package:movie_app_clean_code/src/domain/entities/language_entity.dart';

class Lanuages {
  const Lanuages._();

  static List<LanguageEntity> languages = [
    LanguageEntity(code: 'en', name: 'English'),
    LanguageEntity(code: 'es', name: 'Spanish'),
  ];
}
