
import 'package:flutter/material.dart';
import 'package:flutter_movie_playground/models/movieModel.dart';
import 'package:flutter_movie_playground/screens/MovieDetails.dart';
import 'package:flutter_movie_playground/screens/movielistpage.dart';
import 'package:flutter_movie_playground/screens/searchpage.dart';
import 'package:flutter_movie_playground/utils/Constants.dart';

void main() => runApp(MyApp());

var firstPos = 0;
var changeHeaderCallback;

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Constants.APP_NAME,
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case RouteNames.HOME:
            return MaterialPageRoute(builder: (context) {
              return searchPage();
            });
            break;
          case RouteNames.MOVIE_LIST:
            return MaterialPageRoute(builder: (context) {
              MovieListPageArgs movie = settings.arguments;
              return movieListPage(movie_name: movie.movie_name);
            });
            break;
          case RouteNames.MOVIE_DETAILS:
            return MaterialPageRoute(builder: (context) {
              //MovieListPageArgs movie = settings.arguments;
              return MovieDetailsPage();
            });
            break;
        }
      },
    );
  }
}
