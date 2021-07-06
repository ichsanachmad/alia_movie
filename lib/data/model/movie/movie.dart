import 'package:json_annotation/json_annotation.dart';

part 'movie.g.dart';

@JsonSerializable()
class Movie {
  late int id;
  late String title;

  @JsonKey(name: 'poster_path')
  late String imagePath;

  @JsonKey(name: 'release_date')
  late String releaseDate;

  late String overview;

  Movie({
    required this.id,
    required this.imagePath,
    required this.releaseDate,
    required this.overview,
  });

  factory Movie.fromJson(Map<String, dynamic> json) => _$MovieFromJson(json);
  Map<String, dynamic> toJson() => _$MovieToJson(this);
}
