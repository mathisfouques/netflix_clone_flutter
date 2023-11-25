import 'package:json_annotation/json_annotation.dart';

part 'cast_dto.g.dart';

@JsonSerializable()
class CastDto {
  @JsonKey(name: "adult")
  final bool adult;
  @JsonKey(name: "gender")
  final int gender;
  @JsonKey(name: "id")
  final int id;
  @JsonKey(name: "known_for_department")
  final String knownForDepartment;
  @JsonKey(name: "name")
  final String name;
  @JsonKey(name: "original_name")
  final String originalName;
  @JsonKey(name: "popularity")
  final double popularity;
  @JsonKey(name: "profile_path")
  final String? profilePath;
  @JsonKey(name: "cast_id")
  final int castId;
  @JsonKey(name: "character")
  final String character;
  @JsonKey(name: "credit_id")
  final String creditId;
  @JsonKey(name: "order")
  final int order;

  CastDto({
    required this.adult,
    required this.gender,
    required this.id,
    required this.knownForDepartment,
    required this.name,
    required this.originalName,
    required this.popularity,
    required this.profilePath,
    required this.castId,
    required this.character,
    required this.creditId,
    required this.order,
  });

  factory CastDto.fromJson(Map<String, dynamic> json) =>
      _$CastDtoFromJson(json);

  Map<String, dynamic> toJson() => _$CastDtoToJson(this);
}
