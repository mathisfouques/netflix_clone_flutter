import 'package:json_annotation/json_annotation.dart';

import '../dto/movie_result_dto.dart';

part 'movie_list_dto.g.dart';

@JsonSerializable()
class MovieListDto {
  @JsonKey(name: "page", defaultValue: 1)
  final int page;
  @JsonKey(name: "results", defaultValue: [])
  final List<MovieResultDto> results;
  @JsonKey(name: "total_pages", defaultValue: 10)
  final int totalPages;
  @JsonKey(name: "total_results", defaultValue: 100)
  final int totalResults;

  MovieListDto({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory MovieListDto.fromJson(Map<String, dynamic> json) =>
      _$MovieListDtoFromJson(json);

  Map<String, dynamic> toJson() => _$MovieListDtoToJson(this);
}
