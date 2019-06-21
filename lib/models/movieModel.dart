import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
part 'movieModel.g.dart';



@JsonSerializable()
class MovieV2 {

  String Title;
  String Year;
  String imdbID;
  String Type;
  String Poster;

  MovieV2(this.Title,this.Year,this.imdbID,this.Type,this.Poster);

  factory MovieV2.fromJson(Map<String, dynamic> json) =>
      _$MovieV2FromJson(json);

}

@JsonSerializable()
class MovieSearchResponse{

  List<MovieV2> Search;
  String totalResults;
  String Response;

  MovieSearchResponse(this.Search,this.totalResults,this.Response);


  factory MovieSearchResponse.fromJson(Map<String, dynamic> json) =>
      _$MovieSearchResponseFromJson(json);

}

class MovieListPageArgs {
  String movie_name;

  MovieListPageArgs({this.movie_name});
}

class Movie {
  String posterPath;
  bool adult;
  String overview;
  String releaseDate;
  List<int> genreIds;
  int id;
  String originalTitle;
  OriginalLanguage originalLanguage;
  String title;
  String backdropPath;
  double popularity;
  int voteCount;
  bool video;
  double voteAverage;

  Movie({
    this.posterPath,
    this.adult,
    this.overview,
    this.releaseDate,
    this.genreIds,
    this.id,
    this.originalTitle,
    this.originalLanguage,
    this.title,
    this.backdropPath,
    this.popularity,
    this.voteCount,
    this.video,
    this.voteAverage,
  });

  factory Movie.fromJson(Map<String, dynamic> json) => new Movie(
    posterPath: json["poster_path"] == null ? null : json["poster_path"],
    adult: json["adult"] == null ? null : json["adult"],
    overview: json["overview"] == null ? null : json["overview"],
    releaseDate: json["release_date"] == null ? null : json["release_date"],
    genreIds: json["genre_ids"] == null ? null : new List<int>.from(json["genre_ids"].map((x) => x)),
    id: json["id"] == null ? null : json["id"],
    originalTitle: json["original_title"] == null ? null : json["original_title"],
    originalLanguage: json["original_language"] == null ? null : originalLanguageValues.map[json["original_language"]],
    title: json["title"] == null ? null : json["title"],
    backdropPath: json["backdrop_path"] == null ? null : json["backdrop_path"],
    popularity: json["popularity"] == null ? null : json["popularity"].toDouble(),
    voteCount: json["vote_count"] == null ? null : json["vote_count"],
    video: json["video"] == null ? null : json["video"],
    voteAverage: json["vote_average"] == null ? null : json["vote_average"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "poster_path": posterPath == null ? null : posterPath,
    "adult": adult == null ? null : adult,
    "overview": overview == null ? null : overview,
    "release_date": releaseDate == null ? null : releaseDate,
    "genre_ids": genreIds == null ? null : new List<dynamic>.from(genreIds.map((x) => x)),
    "id": id == null ? null : id,
    "original_title": originalTitle == null ? null : originalTitle,
    "original_language": originalLanguage == null ? null : originalLanguageValues.reverse[originalLanguage],
    "title": title == null ? null : title,
    "backdrop_path": backdropPath == null ? null : backdropPath,
    "popularity": popularity == null ? null : popularity,
    "vote_count": voteCount == null ? null : voteCount,
    "video": video == null ? null : video,
    "vote_average": voteAverage == null ? null : voteAverage,
  };
}

enum OriginalLanguage { EN, ZH, IT }

final originalLanguageValues = new EnumValues({
  "en": OriginalLanguage.EN,
  "it": OriginalLanguage.IT,
  "zh": OriginalLanguage.ZH
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}

class Casts {
  List<Cast> cast;
  List<Crew> crew;

  Casts({
    this.cast,
    this.crew,
  });

  factory Casts.fromJson(Map<String, dynamic> json) => new Casts(
    cast: json["cast"] == null ? null : new List<Cast>.from(json["cast"].map((x) => Cast.fromJson(x))),
    crew: json["crew"] == null ? null : new List<Crew>.from(json["crew"].map((x) => Crew.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "cast": cast == null ? null : new List<dynamic>.from(cast.map((x) => x.toJson())),
    "crew": crew == null ? null : new List<dynamic>.from(crew.map((x) => x.toJson())),
  };
}

class Cast {
  int castId;
  String character;
  String creditId;
  int gender;
  int id;
  String name;
  int order;
  String profilePath;

  Cast({
    this.castId,
    this.character,
    this.creditId,
    this.gender,
    this.id,
    this.name,
    this.order,
    this.profilePath,
  });

  factory Cast.fromJson(Map<String, dynamic> json) => new Cast(
    castId: json["cast_id"] == null ? null : json["cast_id"],
    character: json["character"] == null ? null : json["character"],
    creditId: json["credit_id"] == null ? null : json["credit_id"],
    gender: json["gender"] == null ? null : json["gender"],
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
    order: json["order"] == null ? null : json["order"],
    profilePath: json["profile_path"] == null ? null : json["profile_path"],
  );

  Map<String, dynamic> toJson() => {
    "cast_id": castId == null ? null : castId,
    "character": character == null ? null : character,
    "credit_id": creditId == null ? null : creditId,
    "gender": gender == null ? null : gender,
    "id": id == null ? null : id,
    "name": name == null ? null : name,
    "order": order == null ? null : order,
    "profile_path": profilePath == null ? null : profilePath,
  };
}

class Crew {
  String creditId;
  Department department;
  int gender;
  int id;
  String job;
  String name;
  String profilePath;

  Crew({
    this.creditId,
    this.department,
    this.gender,
    this.id,
    this.job,
    this.name,
    this.profilePath,
  });

  factory Crew.fromJson(Map<String, dynamic> json) => new Crew(
    creditId: json["credit_id"] == null ? null : json["credit_id"],
    department: json["department"] == null ? null : departmentValues.map[json["department"]],
    gender: json["gender"] == null ? null : json["gender"],
    id: json["id"] == null ? null : json["id"],
    job: json["job"] == null ? null : json["job"],
    name: json["name"] == null ? null : json["name"],
    profilePath: json["profile_path"] == null ? null : json["profile_path"],
  );

  Map<String, dynamic> toJson() => {
    "credit_id": creditId == null ? null : creditId,
    "department": department == null ? null : departmentValues.reverse[department],
    "gender": gender == null ? null : gender,
    "id": id == null ? null : id,
    "job": job == null ? null : job,
    "name": name == null ? null : name,
    "profile_path": profilePath == null ? null : profilePath,
  };
}

enum Department { ART, EDITING, DIRECTING, PRODUCTION, CAMERA, SOUND, WRITING, COSTUME_MAKE_UP, CREW, VISUAL_EFFECTS, LIGHTING }

final departmentValues = new EnumValues({
  "Art": Department.ART,
  "Camera": Department.CAMERA,
  "Costume & Make-Up": Department.COSTUME_MAKE_UP,
  "Crew": Department.CREW,
  "Directing": Department.DIRECTING,
  "Editing": Department.EDITING,
  "Lighting": Department.LIGHTING,
  "Production": Department.PRODUCTION,
  "Sound": Department.SOUND,
  "Visual Effects": Department.VISUAL_EFFECTS,
  "Writing": Department.WRITING
});

class Genre {
  int id;
  String name;

  Genre({
    this.id,
    this.name,
  });

  factory Genre.fromJson(Map<String, dynamic> json) => new Genre(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "name": name == null ? null : name,
  };
}

class Images {
  List<Backdrop> backdrops;
  List<Backdrop> posters;

  Images({
    this.backdrops,
    this.posters,
  });

  factory Images.fromJson(Map<String, dynamic> json) => new Images(
    backdrops: json["backdrops"] == null ? null : new List<Backdrop>.from(json["backdrops"].map((x) => Backdrop.fromJson(x))),
    posters: json["posters"] == null ? null : new List<Backdrop>.from(json["posters"].map((x) => Backdrop.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "backdrops": backdrops == null ? null : new List<dynamic>.from(backdrops.map((x) => x.toJson())),
    "posters": posters == null ? null : new List<dynamic>.from(posters.map((x) => x.toJson())),
  };
}

class Backdrop {
  double aspectRatio;
  String filePath;
  int height;
  String iso6391;
  double voteAverage;
  int voteCount;
  int width;

  Backdrop({
    this.aspectRatio,
    this.filePath,
    this.height,
    this.iso6391,
    this.voteAverage,
    this.voteCount,
    this.width,
  });

  factory Backdrop.fromJson(Map<String, dynamic> json) => new Backdrop(
    aspectRatio: json["aspect_ratio"] == null ? null : json["aspect_ratio"].toDouble(),
    filePath: json["file_path"] == null ? null : json["file_path"],
    height: json["height"] == null ? null : json["height"],
    iso6391: json["iso_639_1"] == null ? null : json["iso_639_1"],
    voteAverage: json["vote_average"] == null ? null : json["vote_average"].toDouble(),
    voteCount: json["vote_count"] == null ? null : json["vote_count"],
    width: json["width"] == null ? null : json["width"],
  );

  Map<String, dynamic> toJson() => {
    "aspect_ratio": aspectRatio == null ? null : aspectRatio,
    "file_path": filePath == null ? null : filePath,
    "height": height == null ? null : height,
    "iso_639_1": iso6391 == null ? null : iso6391,
    "vote_average": voteAverage == null ? null : voteAverage,
    "vote_count": voteCount == null ? null : voteCount,
    "width": width == null ? null : width,
  };
}

class ProductionCompany {
  int id;
  String logoPath;
  String name;
  String originCountry;

  ProductionCompany({
    this.id,
    this.logoPath,
    this.name,
    this.originCountry,
  });

  factory ProductionCompany.fromJson(Map<String, dynamic> json) => new ProductionCompany(
    id: json["id"] == null ? null : json["id"],
    logoPath: json["logo_path"] == null ? null : json["logo_path"],
    name: json["name"] == null ? null : json["name"],
    originCountry: json["origin_country"] == null ? null : json["origin_country"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "logo_path": logoPath == null ? null : logoPath,
    "name": name == null ? null : name,
    "origin_country": originCountry == null ? null : originCountry,
  };
}

class ProductionCountry {
  String iso31661;
  String name;

  ProductionCountry({
    this.iso31661,
    this.name,
  });

  factory ProductionCountry.fromJson(Map<String, dynamic> json) => new ProductionCountry(
    iso31661: json["iso_3166_1"] == null ? null : json["iso_3166_1"],
    name: json["name"] == null ? null : json["name"],
  );

  Map<String, dynamic> toJson() => {
    "iso_3166_1": iso31661 == null ? null : iso31661,
    "name": name == null ? null : name,
  };
}

class SpokenLanguage {
  String iso6391;
  String name;

  SpokenLanguage({
    this.iso6391,
    this.name,
  });

  factory SpokenLanguage.fromJson(Map<String, dynamic> json) => new SpokenLanguage(
    iso6391: json["iso_639_1"] == null ? null : json["iso_639_1"],
    name: json["name"] == null ? null : json["name"],
  );

  Map<String, dynamic> toJson() => {
    "iso_639_1": iso6391 == null ? null : iso6391,
    "name": name == null ? null : name,
  };
}

class Videos {
  List<Result> results;

  Videos({
    this.results,
  });

  factory Videos.fromJson(Map<String, dynamic> json) => new Videos(
    results: json["results"] == null ? null : new List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "results": results == null ? null : new List<dynamic>.from(results.map((x) => x.toJson())),
  };
}

class Result {
  String id;
  String iso6391;
  String iso31661;
  String key;
  String name;
  String site;
  int size;
  String type;

  Result({
    this.id,
    this.iso6391,
    this.iso31661,
    this.key,
    this.name,
    this.site,
    this.size,
    this.type,
  });

  factory Result.fromJson(Map<String, dynamic> json) => new Result(
    id: json["id"] == null ? null : json["id"],
    iso6391: json["iso_639_1"] == null ? null : json["iso_639_1"],
    iso31661: json["iso_3166_1"] == null ? null : json["iso_3166_1"],
    key: json["key"] == null ? null : json["key"],
    name: json["name"] == null ? null : json["name"],
    site: json["site"] == null ? null : json["site"],
    size: json["size"] == null ? null : json["size"],
    type: json["type"] == null ? null : json["type"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "iso_639_1": iso6391 == null ? null : iso6391,
    "iso_3166_1": iso31661 == null ? null : iso31661,
    "key": key == null ? null : key,
    "name": name == null ? null : name,
    "site": site == null ? null : site,
    "size": size == null ? null : size,
    "type": type == null ? null : type,
  };
}




