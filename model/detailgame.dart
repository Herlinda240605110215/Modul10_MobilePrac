import 'package:json_annotation/json_annotation.dart';

part 'detailgame.g.dart';

@JsonSerializable()
class MinimumSystemRequirements {
  @JsonKey(name: 'graphics')
  String? graphics;

  @JsonKey(name: 'memory')
  String? memory;

  @JsonKey(name: 'os')
  String? os;

  @JsonKey(name: 'processor')
  String? processor;

  @JsonKey(name: 'storage')
  String? storage;

  MinimumSystemRequirements({
    this.graphics,
    this.memory,
    this.os,
    this.processor,
    this.storage,
  });

  factory MinimumSystemRequirements.fromJson(
      Map<String, dynamic> json,
      ) =>
      _$MinimumSystemRequirementsFromJson(json);

  Map<String, dynamic> toJson() =>
      _$MinimumSystemRequirementsToJson(this);
}

@JsonSerializable()
class Screenshot {
  int? id;
  String? image;

  Screenshot({
    this.id,
    this.image,
  });

  factory Screenshot.fromJson(
      Map<String, dynamic> json,
      ) =>
      _$ScreenshotFromJson(json);

  Map<String, dynamic> toJson() =>
      _$ScreenshotToJson(this);
}

@JsonSerializable()
class DetailGame {
  int? id;
  String? title;
  String? thumbnail;

  @JsonKey(name: 'short_description')
  String? shortDescription;

  @JsonKey(name: 'game_url')
  String? gameUrl;

  String? genre;
  String? platform;
  String? publisher;
  String? developer;

  @JsonKey(name: 'release_date')
  String? releaseDate;

  @JsonKey(name: 'freetogame_profile_url')
  String? freetogameProfileUrl;

  String? description;

  @JsonKey(name: 'minimum_system_requirements')
  MinimumSystemRequirements? minimumSystemRequirements;

  List<Screenshot>? screenshots;

  DetailGame({
    this.id,
    this.title,
    this.thumbnail,
    this.shortDescription,
    this.gameUrl,
    this.genre,
    this.platform,
    this.publisher,
    this.developer,
    this.releaseDate,
    this.freetogameProfileUrl,
    this.description,
    this.minimumSystemRequirements,
    this.screenshots,
  });

  factory DetailGame.fromJson(
      Map<String, dynamic> json,
      ) =>
      _$DetailGameFromJson(json);

  Map<String, dynamic> toJson() =>
      _$DetailGameToJson(this);
}
