
import 'dart:convert';

import 'package:flutter_movie_playground/models/movieModel.dart';
import 'package:http/http.dart' as http;

const API_KEY = "25e8192f";

Future<MovieSearchResponse> getMovies(String name) async{

  var response = await http.get("http://www.omdbapi.com/?apikey=$API_KEY&s=$name");
  final jsonData = json.decode(response.body);
  print('searching for - $name');
  /*print('response is ${response.body}');
  print('json data is $jsonData');*/
  return MovieSearchResponse.fromJson(jsonData);
}