// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_list_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieListDto _$MovieListDtoFromJson(Map<String, dynamic> json) => MovieListDto(
      page: json['page'] as int? ?? 1,
      results: (json['results'] as List<dynamic>?)
              ?.map((e) => MovieResultDto.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      totalPages: json['total_pages'] as int? ?? 10,
      totalResults: json['total_results'] as int? ?? 100,
    );

Map<String, dynamic> _$MovieListDtoToJson(MovieListDto instance) =>
    <String, dynamic>{
      'page': instance.page,
      'results': instance.results,
      'total_pages': instance.totalPages,
      'total_results': instance.totalResults,
    };
