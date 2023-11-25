import 'package:json_annotation/json_annotation.dart';

part 'crew_dto.g.dart';

@JsonSerializable()
class CrewDto {
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
  @JsonKey(name: "credit_id")
  final String creditId;
  @JsonKey(name: "department")
  final String department;
  @JsonKey(name: "job")
  final String job;

  CrewDto({
    required this.adult,
    required this.gender,
    required this.id,
    required this.knownForDepartment,
    required this.name,
    required this.originalName,
    required this.popularity,
    required this.profilePath,
    required this.creditId,
    required this.department,
    required this.job,
  });

  factory CrewDto.fromJson(Map<String, dynamic> json) =>
      _$CrewDtoFromJson(json);

  Map<String, dynamic> toJson() => _$CrewDtoToJson(this);
}
