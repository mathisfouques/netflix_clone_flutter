// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_videos_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieVideosDto _$MovieVideosDtoFromJson(Map<String, dynamic> json) =>
    MovieVideosDto(
      id: json['id'] as int,
      results: (json['results'] as List<dynamic>)
          .map((e) => MovieVideoResultDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MovieVideosDtoToJson(MovieVideosDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'results': instance.results,
    };
