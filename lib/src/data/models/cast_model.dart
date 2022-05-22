import 'package:movie_app_clean_code/src/domain/entities/cast_entity.dart';

class CastModel extends CastEntity {
  const CastModel({
    required super.creditId,
    required super.name,
    super.profilePath,
    required super.character,
  });

  factory CastModel.fromJson(Map<String, dynamic> json) {
    return CastModel(
      creditId: json['credit_id'],
      name: json['name'],
      profilePath: json['profile_path'],
      character: json['character'],
    );
  }
}
