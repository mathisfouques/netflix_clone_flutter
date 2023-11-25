import 'package:json_annotation/json_annotation.dart';

import 'movie_video_result_dto.dart';

part 'movie_videos_dto.g.dart';

@JsonSerializable()
class MovieVideosDto {
  @JsonKey(name: "id")
  final int id;
  @JsonKey(name: "results")
  final List<MovieVideoResultDto> results;

  MovieVideosDto({
    required this.id,
    required this.results,
  });

  factory MovieVideosDto.fromJson(Map<String, dynamic> json) =>
      _$MovieVideosDtoFromJson(json);

  Map<String, dynamic> toJson() => _$MovieVideosDtoToJson(this);
}
