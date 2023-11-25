import 'package:json_annotation/json_annotation.dart';

part 'movie_video_result_dto.g.dart';

@JsonSerializable()
class MovieVideoResultDto {
  @JsonKey(name: "iso_639_1")
  final String iso6391;
  @JsonKey(name: "iso_3166_1")
  final String iso31661;
  @JsonKey(name: "name")
  final String name;
  @JsonKey(name: "key")
  final String key;
  @JsonKey(name: "site")
  final String site;
  @JsonKey(name: "size")
  final int size;
  @JsonKey(name: "type")
  final String type;
  @JsonKey(name: "official")
  final bool official;
  @JsonKey(name: "published_at")
  final String publishedAt;
  @JsonKey(name: "id")
  final String id;

  MovieVideoResultDto({
    required this.iso6391,
    required this.iso31661,
    required this.name,
    required this.key,
    required this.site,
    required this.size,
    required this.type,
    required this.official,
    required this.publishedAt,
    required this.id,
  });

  factory MovieVideoResultDto.fromJson(Map<String, dynamic> json) =>
      _$MovieVideoResultDtoFromJson(json);

  Map<String, dynamic> toJson() => _$MovieVideoResultDtoToJson(this);
}
