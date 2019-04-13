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

MovieDetailResponse movieDetailResponseFromJson(String str) {
  final jsonData = json.decode(str);
  return MovieDetailResponse.fromJson(jsonData);
}

String movieDetailResponseToJson(MovieDetailResponse data) {
  final dyn = data.toJson();
  return json.encode(dyn);
}

class MovieDetailResponse {
  bool adult;
  String backdropPath;
  dynamic belongsToCollection;
  int budget;
  List<Genre> genres;
  String homepage;
  int id;
  String imdbId;
  String originalLanguage;
  String originalTitle;
  String overview;
  double popularity;
  String posterPath;
  List<ProductionCompany> productionCompanies;
  List<ProductionCountry> productionCountries;
  String releaseDate;
  int revenue;
  int runtime;
  List<SpokenLanguage> spokenLanguages;
  String status;
  String tagline;
  String title;
  bool video;
  double voteAverage;
  int voteCount;

  MovieDetailResponse({
    this.adult,
    this.backdropPath,
    this.belongsToCollection,
    this.budget,
    this.genres,
    this.homepage,
    this.id,
    this.imdbId,
    this.originalLanguage,
    this.originalTitle,
    this.overview,
    this.popularity,
    this.posterPath,
    this.productionCompanies,
    this.productionCountries,
    this.releaseDate,
    this.revenue,
    this.runtime,
    this.spokenLanguages,
    this.status,
    this.tagline,
    this.title,
    this.video,
    this.voteAverage,
    this.voteCount,
  });

  factory MovieDetailResponse.fromJson(Map<String, dynamic> json) => new MovieDetailResponse(
    adult: json["adult"] == null ? null : json["adult"],
    backdropPath: json["backdrop_path"] == null ? null : json["backdrop_path"],
    belongsToCollection: json["belongs_to_collection"],
    budget: json["budget"] == null ? null : json["budget"],
    genres: json["genres"] == null ? null : new List<Genre>.from(json["genres"].map((x) => Genre.fromJson(x))),
    homepage: json["homepage"] == null ? null : json["homepage"],
    id: json["id"] == null ? null : json["id"],
    imdbId: json["imdb_id"] == null ? null : json["imdb_id"],
    originalLanguage: json["original_language"] == null ? null : json["original_language"],
    originalTitle: json["original_title"] == null ? null : json["original_title"],
    overview: json["overview"] == null ? null : json["overview"],
    popularity: json["popularity"] == null ? null : json["popularity"].toDouble(),
    posterPath: json["poster_path"] == null ? null : json["poster_path"],
    productionCompanies: json["production_companies"] == null ? null : new List<ProductionCompany>.from(json["production_companies"].map((x) => ProductionCompany.fromJson(x))),
    productionCountries: json["production_countries"] == null ? null : new List<ProductionCountry>.from(json["production_countries"].map((x) => ProductionCountry.fromJson(x))),
    releaseDate: json["release_date"] == null ? null : json["release_date"],
    revenue: json["revenue"] == null ? null : json["revenue"],
    runtime: json["runtime"] == null ? null : json["runtime"],
    spokenLanguages: json["spoken_languages"] == null ? null : new List<SpokenLanguage>.from(json["spoken_languages"].map((x) => SpokenLanguage.fromJson(x))),
    status: json["status"] == null ? null : json["status"],
    tagline: json["tagline"] == null ? null : json["tagline"],
    title: json["title"] == null ? null : json["title"],
    video: json["video"] == null ? null : json["video"],
    voteAverage: json["vote_average"] == null ? null : json["vote_average"].toDouble(),
    voteCount: json["vote_count"] == null ? null : json["vote_count"],
  );

  Map<String, dynamic> toJson() => {
    "adult": adult == null ? null : adult,
    "backdrop_path": backdropPath == null ? null : backdropPath,
    "belongs_to_collection": belongsToCollection,
    "budget": budget == null ? null : budget,
    "genres": genres == null ? null : new List<dynamic>.from(genres.map((x) => x.toJson())),
    "homepage": homepage == null ? null : homepage,
    "id": id == null ? null : id,
    "imdb_id": imdbId == null ? null : imdbId,
    "original_language": originalLanguage == null ? null : originalLanguage,
    "original_title": originalTitle == null ? null : originalTitle,
    "overview": overview == null ? null : overview,
    "popularity": popularity == null ? null : popularity,
    "poster_path": posterPath == null ? null : posterPath,
    "production_companies": productionCompanies == null ? null : new List<dynamic>.from(productionCompanies.map((x) => x.toJson())),
    "production_countries": productionCountries == null ? null : new List<dynamic>.from(productionCountries.map((x) => x.toJson())),
    "release_date": releaseDate == null ? null : releaseDate,
    "revenue": revenue == null ? null : revenue,
    "runtime": runtime == null ? null : runtime,
    "spoken_languages": spokenLanguages == null ? null : new List<dynamic>.from(spokenLanguages.map((x) => x.toJson())),
    "status": status == null ? null : status,
    "tagline": tagline == null ? null : tagline,
    "title": title == null ? null : title,
    "video": video == null ? null : video,
    "vote_average": voteAverage == null ? null : voteAverage,
    "vote_count": voteCount == null ? null : voteCount,
  };
}

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

MovieSearchResponseV2 movieSearchResponseV2FromJson(String str) {
  final jsonData = json.decode(str);
  return MovieSearchResponseV2.fromJson(jsonData);
}

String movieSearchResponseV2ToJson(MovieSearchResponseV2 data) {
  final dyn = data.toJson();
  return json.encode(dyn);
}

class MovieSearchResponseV2 {
  int page;
  List<Movie> results;
  int totalResults;
  int totalPages;

  MovieSearchResponseV2({
    this.page,
    this.results,
    this.totalResults,
    this.totalPages,
  });

  factory MovieSearchResponseV2.fromJson(Map<String, dynamic> json) => new MovieSearchResponseV2(
    page: json["page"] == null ? null : json["page"],
    results: json["results"] == null ? null : new List<Movie>.from(json["results"].map((x) => Movie.fromJson(x))),
    totalResults: json["total_results"] == null ? null : json["total_results"],
    totalPages: json["total_pages"] == null ? null : json["total_pages"],
  );

  Map<String, dynamic> toJson() => {
    "page": page == null ? null : page,
    "results": results == null ? null : new List<dynamic>.from(results.map((x) => x.toJson())),
    "total_results": totalResults == null ? null : totalResults,
    "total_pages": totalPages == null ? null : totalPages,
  };
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



