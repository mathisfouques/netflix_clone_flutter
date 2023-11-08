// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'genre_list_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GenreListDto _$GenreListDtoFromJson(Map<String, dynamic> json) => GenreListDto(
      genres: (json['genres'] as List<dynamic>)
          .map((e) => GenreDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GenreListDtoToJson(GenreListDto instance) =>
    <String, dynamic>{
      'genres': instance.genres,
    };
