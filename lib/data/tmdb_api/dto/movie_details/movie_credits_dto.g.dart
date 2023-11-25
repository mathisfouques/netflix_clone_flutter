// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_credits_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieCreditsDto _$MovieCreditsDtoFromJson(Map<String, dynamic> json) =>
    MovieCreditsDto(
      id: json['id'] as int,
      cast: (json['cast'] as List<dynamic>)
          .map((e) => CastDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      crew: (json['crew'] as List<dynamic>)
          .map((e) => CrewDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MovieCreditsDtoToJson(MovieCreditsDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'cast': instance.cast,
      'crew': instance.crew,
    };
