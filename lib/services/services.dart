
import 'dart:convert';

import 'package:flutter_movie_playground/models/movieModel.dart';
import 'package:flutter_movie_playground/utils/Constants.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_movie_playground/utils/NetworkUtil.dart';

const API_KEY = "25e8192f";
var dio = getDio(ApiBaseUrls.TMDB);

Future<MovieSearchResponse> getMovies(String name) async{

  var response = await http.get("${ApiBaseUrls.OMDB}/?apikey=${ApiKeys.OMDB_API_KEY}&s=$name");
  final jsonData = json.decode(response.body);
  print('searching for - $name');
  /*print('response is ${response.body}');
  print('json data is $jsonData');*/
  return MovieSearchResponse.fromJson(jsonData);
}

Future<MovieSearchResponseV2> getMoviesv2(String name,{int currentPageNumber = 1}) async{

  var response = await dio.get("/search/movie",queryParameters: {
    "query" : name,
    "page" : currentPageNumber
  });

  return MovieSearchResponseV2.fromJson(response.data);
}

Future<MovieDetailResponse> getMovieDetail(int movieId) async{
  var response = await getDio(ApiBaseUrls.TMDB).get("/movie/$movieId");
  return MovieDetailResponse.fromJson(response.data);
}



//Future<MovieDetail> getMovieDetail(String imdbID) async{
//
//  var response = await http.get("${ApiBaseUrls.TMDB}");
//  final jsonData = json.decode(response.body);
//  print('searching for - $name');
//  /*print('response is ${response.body}');
//  print('json data is $jsonData');*/
//  return MovieSearchResponse.fromJson(jsonData);
//}