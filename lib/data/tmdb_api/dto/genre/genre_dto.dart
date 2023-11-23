import 'package:json_annotation/json_annotation.dart';

part 'genre_dto.g.dart';

@JsonSerializable()
class GenreDto {
  @JsonKey(name: "id")
  final int id;
  @JsonKey(name: "name")
  final String name;

  GenreDto({
    required this.id,
    required this.name,
  });

  factory GenreDto.fromJson(Map<String, dynamic> json) =>
      _$GenreDtoFromJson(json);

  Map<String, dynamic> toJson() => _$GenreDtoToJson(this);
}
