import 'package:json_annotation/json_annotation.dart';

import 'genre_dto.dart';

part 'genre_list_dto.g.dart';

@JsonSerializable()
class GenreListDto {
  @JsonKey(name: "genres")
  final List<GenreDto> genres;

  GenreListDto({
    required this.genres,
  });

  factory GenreListDto.fromJson(Map<String, dynamic> json) =>
      _$GenreListDtoFromJson(json);

  Map<String, dynamic> toJson() => _$GenreListDtoToJson(this);
}
