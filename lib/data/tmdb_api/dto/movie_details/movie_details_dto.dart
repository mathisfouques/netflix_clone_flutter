import 'package:json_annotation/json_annotation.dart';

import '../genre/genre_dto.dart';
import 'production_company_dto.dart';
import 'production_country_dto.dart';
import 'spoken_language_dto.dart';

part 'movie_details_dto.g.dart';

@JsonSerializable()
class MovieDetailsDto {
  @JsonKey(name: "adult")
  final bool adult;
  @JsonKey(name: "backdrop_path")
  final String backdropPath;
  @JsonKey(name: "belongs_to_collection")
  final dynamic belongsToCollection;
  @JsonKey(name: "budget")
  final int budget;
  @JsonKey(name: "genres")
  final List<GenreDto> genres;
  @JsonKey(name: "homepage")
  final String homepage;
  @JsonKey(name: "id")
  final int id;
  @JsonKey(name: "imdb_id")
  final String imdbId;
  @JsonKey(name: "original_language")
  final String originalLanguage;
  @JsonKey(name: "original_title")
  final String originalTitle;
  @JsonKey(name: "overview")
  final String overview;
  @JsonKey(name: "popularity")
  final double popularity;
  @JsonKey(name: "poster_path")
  final String posterPath;
  @JsonKey(name: "production_companies")
  final List<ProductionCompanyDto> productionCompanies;
  @JsonKey(name: "production_countries")
  final List<ProductionCountryDto> productionCountries;
  @JsonKey(name: "release_date")
  final String releaseDate;
  @JsonKey(name: "revenue")
  final int revenue;
  @JsonKey(name: "runtime")
  final int runtime;
  @JsonKey(name: "spoken_languages")
  final List<SpokenLanguageDto> spokenLanguages;
  @JsonKey(name: "status")
  final String status;
  @JsonKey(name: "tagline")
  final String tagline;
  @JsonKey(name: "title")
  final String title;
  @JsonKey(name: "video")
  final bool video;
  @JsonKey(name: "vote_average")
  final double voteAverage;
  @JsonKey(name: "vote_count")
  final int voteCount;

  MovieDetailsDto({
    required this.adult,
    required this.backdropPath,
    required this.belongsToCollection,
    required this.budget,
    required this.genres,
    required this.homepage,
    required this.id,
    required this.imdbId,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.productionCompanies,
    required this.productionCountries,
    required this.releaseDate,
    required this.revenue,
    required this.runtime,
    required this.spokenLanguages,
    required this.status,
    required this.tagline,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });

  factory MovieDetailsDto.fromJson(Map<String, dynamic> json) =>
      _$MovieDetailsDtoFromJson(json);

  Map<String, dynamic> toJson() => _$MovieDetailsDtoToJson(this);
}
