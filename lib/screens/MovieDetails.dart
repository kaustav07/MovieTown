import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_movie_playground/models/movieModel.dart';
import 'package:flutter_movie_playground/screens/movielistpage.dart';
import 'dart:math';
import 'package:flutter_movie_playground/utils/Utility.dart';
import 'package:flutter_movie_playground/services/services.dart';
import 'package:flutter_advanced_networkimage/provider.dart';
import 'package:flutter_movie_playground/utils/Constants.dart';
import 'package:youtube_player/youtube_player.dart';

Movie global_movie;

class MovieDetailsPage extends StatefulWidget {
  MovieDetailsPage(this.movie) {
    global_movie = movie;
  }

  Movie movie;

  @override
  State createState() => MovieDetailPageState();
}

class MovieDetailPageState extends State<MovieDetailsPage> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: Colors.black12, //or set color with: Color(0xFF0000FF)
    ));

    return Scaffold(
      body: SafeArea(child: _movieDetail(widget.movie.id)),
    );
  }

  Widget _movieDetail(int movieId) {
    return FutureBuilder<MovieDetailResponse>(
      future: getMovieDetail(movieId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.data != null) {
          MovieDetailResponse movie = snapshot.data;
          return _DetailPage(true, movie, widget.movie);
        } else {
          return _DetailPage(false, null, widget.movie);
        }
      },
    );
  }

  Widget _DetailPage(
      bool hasdata, MovieDetailResponse movieDetail, Movie passedMovie) {
    if (hasdata && movieDetail != null) {
      return Column(
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
                  image: movieDetail.backdropPath == null
                      ? AssetImage('images/loyaltybg.png')
                      : AdvancedNetworkImage(
                          ApiBaseUrls.TMDB_IMAGE + movieDetail.backdropPath,
                          scale: 0.85,
                          useDiskCache: true,
                          cacheRule: CacheRule(maxAge: Duration(days: 5)),
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
                    tag: 'movie_poster_${movieDetail.id}',
                    child: SizedBox(
                      height: 150,
                      child: myListItem(
                          passedMovie.posterPath, passedMovie.title, 150),
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
      );
    } else {
      return Column(
        children: <Widget>[
          Stack(
            overflow: Overflow.visible,
            children: <Widget>[
              Container(
                height: 220,
                width: double.infinity,
                child: FadeInImage(
                  placeholder: AssetImage('images/placeholder.png'),
                  image: passedMovie.backdropPath == null
                      ? AssetImage('images/loyaltybg.png')
                      : AdvancedNetworkImage(
                          ApiBaseUrls.TMDB_IMAGE + passedMovie.backdropPath,
                          scale: 0.85,
                          useDiskCache: true,
                          cacheRule: CacheRule(maxAge: Duration(days: 5)),
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
                    tag: 'movie_poster_${passedMovie.id}',
                    child: SizedBox(
                      height: 150,
                      child: myListItem(
                          passedMovie.posterPath, passedMovie.title, 150),
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
      );
    }
  }
}

class MyYoutubePlayer extends StatefulWidget {
  MyYoutubePlayer({this.playState});

  bool playState = false;

  @override
  State createState() => MyYoutubePlayerState();
}

class MyYoutubePlayerState extends State<MyYoutubePlayer> {
  @override
  Widget build(BuildContext context) {
    YoutubePlayer(
      source: "nPt8bK2gbaU",
      quality: YoutubeQuality.HD,
      aspectRatio: 16 / 9,
      showThumbnail: true,
    );
  }
}

class MyyPainter extends CustomPainter {
  var mycolor = Colors.blue;

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = mycolor
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;

    var startPath = Path();
    var new_outer_RAD;
    var half_new_outer_RAD;
    var RAD_distance = (2 * pi / 5);
    var RAD_half_PI = pi / 2;
    var start_x = 10;
    var start_y = 10;
    var outer_radius = 100;
    var inner_radius = 40;

    var alpha = (2 * pi) / 10;
    var radius = 12;
    var starXY = [100, 100];

    /*for(var i = 11; i != 0; i--)
    {
      var r = radius*(i % 2 + 1)/2;
      var omega = alpha * i;
      startPath.lineTo((r * sin(omega)) + starXY[0], (r * cos(omega)) + starXY[1]);
    }*/

    for (var i = 0; i <= 5; i++) {
      new_outer_RAD = (i + 1) * RAD_distance;
      half_new_outer_RAD = new_outer_RAD - (RAD_distance / 2);

      /*if (s) {
        startPath.lineTo(start_x + Math.round(Math.cos(half_new_outer_RAD - RAD_half_PI) * inner_radius), start_y + Math.round(Math.sin(half_new_outer_RAD - RAD_half_PI) * inner_radius));
      }*/

      startPath.lineTo(
          start_x +
              (cos(new_outer_RAD - RAD_half_PI) * outer_radius)
                  .round()
                  .toDouble(),
          start_y +
              (sin(new_outer_RAD - RAD_half_PI) * outer_radius)
                  .roundToDouble());
    }
    //startPath.close();

    var path = Path()
      ..moveTo(0, 100)
      ..lineTo(50, 0)
      ..lineTo(100, 100);
    canvas.drawPath(startPath, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    if (mycolor != Colors.blue) return true;
  }
}
