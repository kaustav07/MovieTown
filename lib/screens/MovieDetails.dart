import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_movie_playground/models/movieModel.dart';
import 'package:flutter_movie_playground/scopedModels/AppState.dart';
import 'package:flutter_movie_playground/screens/movielistpage.dart';
import 'package:flutter_advanced_networkimage/provider.dart';
import 'package:flutter_movie_playground/utils/Constants.dart';
import 'package:provider/provider.dart';

Movie global_movie;

class MovieDetailsPage extends StatelessWidget {
  MovieDetailPageModel model;

  MovieDetailsPage(this.movie) {
    model = MovieDetailPageModel(movie);
    global_movie = movie;
  }

  Movie movie;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: Colors.black12, //or set color with: Color(0xFF0000FF)
    ));

    return ChangeNotifierProvider<MovieDetailPageModel>(
      builder: (_) => model,
      child: Scaffold(
        body: SafeArea(
            child: Column(
              children: <Widget>[
                Stack(
                  //alignment: Alignment(-0.82,2.94), //2.3 for 120
                  overflow: Overflow.visible,
                  children: <Widget>[
                    Container(
                      height: 220,
                      width: double.infinity,
                      child: FadeInImage(
                        placeholder: AssetImage('images/placeholder.png'),
                        image: model.movie.backdropPath == null
                            ? AssetImage('images/loyaltybg.png')
                            : AdvancedNetworkImage(
                            ApiBaseUrls.TMDB_IMAGE +
                                model.movie.backdropPath,
                            scale: 0.85,
                            useDiskCache: true,
                            cacheRule:
                            CacheRule(maxAge: Duration(days: 5)),
                            retryLimit: 3,
                            printError: true,
                            retryDuration: Duration(seconds: 3)),
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      bottom: -75,
                      left: 20,
                      child: Hero(
                          tag: 'movie_poster_${model.movie.id}',
                          child: SizedBox(
                            height: 150,
                            child: myListItem(model.movie.posterPath,
                                model.movie.title, 150),
                          )),
                    ),
                    Positioned(
                      bottom: -35,
                      right: 20,
                      child: SizedBox(
                        height: 70,
                        width: 70,
                        child: FloatingActionButton(
                          onPressed: null,
                          child: Icon(
                            Icons.play_circle_filled,
                            size: 40,
                          ),
                          backgroundColor: Colors.red,
                          shape: StadiumBorder(
                              side: BorderSide.lerp(
                                  BorderSide(
                                      width: 4,
                                      color: Colors.blue,
                                      style: BorderStyle.solid),
                                  BorderSide(
                                      width: 14,
                                      color: Colors.green,
                                      style: BorderStyle.none),
                                  0.4)),
                        ),
                      ),
                    )
                  ],
                )
              ],
            )),
      )
    );
  }
}
