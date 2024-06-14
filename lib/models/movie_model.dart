import 'package:json_annotation/json_annotation.dart';
import 'package:movie_test/utils/constant_util.dart';

part 'movie_model.g.dart';

@JsonSerializable()
class MovieModel {
  final bool? adult;
  @JsonKey(name: 'backdrop_path')
  final String? backdropPath;
  @JsonKey(name: 'genre_ids')
  final List<int>? genreIds;
  final int? id;
  @JsonKey(name: 'original_language')
  final String? originalLanguage;
  @JsonKey(name: 'original_title')
  final String? originalTitle;
  final String? overview;
  final double? popularity;
  @JsonKey(name: 'poster_path')
  final String? posterPath;
  @JsonKey(name: 'release_date')
  final String? releaseDate;
  final String? title;
  final bool? video;
  @JsonKey(name: 'vote_average')
  final double? voteAverage;
  @JsonKey(name: 'vote_count')
  final int? voteCount;
  final String? homepage;
  final String? tagline;
  final List<dynamic>? genres;
  @JsonKey(name: 'spoken_languages')
  final List<dynamic>? spokenLanguages;
  final String? status;

  String? get poster => posterPath != null ? '${ConstantUtil.posterBaseUrl}$posterPath' : '';

  MovieModel({
    this.adult,
    this.backdropPath,
    this.genreIds,
    this.id,
    this.originalLanguage,
    this.originalTitle,
    this.overview,
    this.popularity,
    this.posterPath,
    this.releaseDate,
    this.title,
    this.video,
    this.voteAverage,
    this.voteCount,
    this.homepage,
    this.tagline,
    this.genres,
    this.spokenLanguages,
    this.status,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) => _$MovieModelFromJson(json);

  Map<String, dynamic> toJson() => _$MovieModelToJson(this);
}
