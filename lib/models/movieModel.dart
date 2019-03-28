
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Movie {

  String Title;
  String Year;
  String imdbID;
  String Type;
  String Poster;

  Movie({this.Title,this.Year,this.imdbID,this.Type,this.Poster});

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
        Title: json['Title'] as String,
        Year: json['Year'] as String,
        imdbID: json['imdbID'] as String,
        Type: json['Type'] as String,
        Poster: json['Poster'] as String);
  }
}

@JsonSerializable()
class MovieSearchResponse{

  List<Movie> Search;
  String totalResults;
  String Response;

  MovieSearchResponse({this.Search,this.totalResults,this.Response});

  factory MovieSearchResponse.fromJson(Map<String, dynamic> json){
    var list = json['Search'] as List;

    List<Movie> movies = list.map((i) => Movie.fromJson(i)).toList();

    return MovieSearchResponse(
      Search: movies,
      totalResults: json['totalResults'] as String,
      Response: json['Response'] as String
    );
  }
}

class MovieListPageArgs {
  String movie_name;

  MovieListPageArgs({this.movie_name});
}