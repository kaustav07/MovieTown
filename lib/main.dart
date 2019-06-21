import 'package:flutter/material.dart';
import 'package:flutter_movie_playground/models/movieModel.dart';
import 'package:flutter_movie_playground/scopedModels/AppState.dart';
import 'package:flutter_movie_playground/screens/MovieDetails.dart';
import 'package:flutter_movie_playground/screens/movielistpage.dart';
import 'package:flutter_movie_playground/screens/searchpage.dart';
import 'package:flutter_movie_playground/utils/Constants.dart';
import 'package:scoped_model/scoped_model.dart';

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
            MovieListPageArgs movie = settings.arguments;
            return PageRouteBuilder<Null>(
                pageBuilder: (BuildContext context,
                    Animation<double> animation,
                    Animation<double> secondaryAnimation) {
                  final page = AnimatedBuilder(
                      animation: animation,
                      builder: (BuildContext context, Widget child) {
                        return Opacity(
                          opacity: animation.value,
                          child: movieListPage(movie.movie_name),
                        );
                      });
                  return page;
                },
                transitionDuration: Duration(milliseconds: 1600));
            break;
          case RouteNames.MOVIE_DETAILS:
            Movie movie = settings.arguments;
            return PageRouteBuilder<Null>(
                pageBuilder: (BuildContext context,
                    Animation<double> animation,
                    Animation<double> secondaryAnimation) {
                  return SlideTransition(
                    position: Tween<Offset>(
                        begin: const Offset(1.0, 0.0), end: Offset.zero)
                        .animate(animation),
                    child: MovieDetailsPage(movie),
                  );
                },
                transitionDuration: Duration(milliseconds: 800));
            /*return MaterialPageRoute(builder: (context) {
              return MovieDetailsPage(movie);
            });*/
            break;
        }
      },
    );
  }
}
