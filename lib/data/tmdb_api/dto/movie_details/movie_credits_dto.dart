import 'package:json_annotation/json_annotation.dart';

import 'cast_dto.dart';
import 'crew_dto.dart';

part 'movie_credits_dto.g.dart';

@JsonSerializable()
class MovieCreditsDto {
  @JsonKey(name: "id")
  final int id;
  @JsonKey(name: "cast")
  final List<CastDto> cast;
  @JsonKey(name: "crew")
  final List<CrewDto> crew;

  MovieCreditsDto({
    required this.id,
    required this.cast,
    required this.crew,
  });

  factory MovieCreditsDto.fromJson(Map<String, dynamic> json) =>
      _$MovieCreditsDtoFromJson(json);

  Map<String, dynamic> toJson() => _$MovieCreditsDtoToJson(this);
}
