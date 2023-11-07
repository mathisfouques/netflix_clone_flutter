import 'package:json_annotation/json_annotation.dart';
import 'package:netflix_clone/models/dto/movie_result_dto.dart';

part 'movie_list_dto.g.dart';

@JsonSerializable()
class MovieListDto {
  @JsonKey(name: "page")
  final int page;
  @JsonKey(name: "results")
  final List<MovieResultDto> results;
  @JsonKey(name: "total_pages")
  final int totalPages;
  @JsonKey(name: "total_results")
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
