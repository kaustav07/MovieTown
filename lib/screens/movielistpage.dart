import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_movie_playground/models/movieModel.dart';
import 'package:flutter_movie_playground/services/services.dart';
import 'package:flutter_movie_playground/utils/Constants.dart';



class movieListPage extends StatelessWidget{

  movieListPage({this.movie_name});

  var movie_name;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: MovieSearchPage(movie_name: movie_name,),
    );
  }
}

class MovieSearchPage extends StatefulWidget {
  MovieSearchPage({this.movie_name});

  var movie_name;

  @override
  _MovieSearchState createState() => _MovieSearchState(movie_name: movie_name);
}

class _MovieSearchState extends State<MovieSearchPage> {
  _MovieSearchState({this.movie_name});

  var movie_name;

  @override
  Widget build(BuildContext context) {

    return FutureBuilder<MovieSearchResponse>(
      future: getMovies(movie_name),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting ||
            snapshot.connectionState != ConnectionState.done) {
          return Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else{
          return Stack(
            children: <Widget>[
              new movieBackgroundWidget(response: snapshot.data),
              new movieListWidget(response: snapshot.data),
              Padding(padding: EdgeInsets.only(left: 20),child: new MovieHeaderWidget(search_term: movie_name,),)
            ],
          );
        }

      },
    );
  }
}

class movieListWidget extends StatelessWidget {
  movieListWidget({Key key, this.response}) : super(key: key);


  final MovieSearchResponse response;

  @override
  Widget build(BuildContext context) {

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Expanded(
          child:ListView.builder(
            padding: EdgeInsets.all(20),
            itemCount: response.Search.length,
            itemBuilder: (context, index) {
              return new movieListItem(response.Search[index]);
            },
            scrollDirection: Axis.horizontal,

          ),
        ),
      ],
    );
  }
}


class movieListItem extends StatelessWidget {
  movieListItem(this.movie);

  Movie movie;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: FractionalOffset.bottomCenter,
      child: GestureDetector(
        onTap: (){
          Navigator.pushNamed(context, RouteNames.MOVIE_DETAILS);
        },
        child: Container(
          margin: EdgeInsets.only(bottom: 100, right: 10),
          height: 250,
          child: Card(
            elevation: 20,
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: Image.network(movie.Poster),
          ),
        ),
      ),
    );

//    return Container(
//      child: Stack(
//        children: <Widget>[
//          Card(
//            child: Container(
//                decoration: BoxDecoration(image: new DecorationImage(
//                    image: new NetworkImage(movie.Poster), fit: BoxFit.cover))
//            ),
//          )
//        ],
//      ),
//    );
  }
}

class movieBackgroundWidget extends StatelessWidget {
  const movieBackgroundWidget({Key key, this.response}) : super(key: key);

  final MovieSearchResponse response;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
            child: Container(
                constraints: BoxConstraints.expand(),
                child: Container(
                  decoration: new BoxDecoration(
                      image: new DecorationImage(
                          image: NetworkImage(!response.Search[0].Poster.contains('N/A') ? response.Search[0].Poster : 'https://m.media-amazon.com/images/M/MV5BNDYxNjQyMjAtNTdiOS00NGYwLWFmNTAtNThmYjU5ZGI2YTI1XkEyXkFqcGdeQXVyMTMxODk2OTU@._V1_SX300.jpg'),
                          fit: BoxFit.cover)),
                  child: new BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
                    child: Container(
                      decoration:
                      BoxDecoration(color: Colors.black.withOpacity(0.5)),
                    ),
                  ),
                )))
      ],
    );
  }
}

class MovieHeaderWidget extends StatelessWidget{

  MovieHeaderWidget({this.search_term});

  var search_term;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 50),
      child: Column(
        children: <Widget>[
          Align(
            alignment: Alignment.topLeft,
            child: IconButton(icon: Icon(Icons.arrow_back,color: Colors.white30.withOpacity(0.35),size: 40,), onPressed: (){
              Navigator.pop(context);
            })),
          Align(
            alignment: Alignment.topLeft,
            child: Container(
              margin: EdgeInsets.only(top: 50),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(left: 10,bottom: 10),
                    child: Text('Searching for...',style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 5,
                        color: Colors.blue,
                        decorationStyle: TextDecorationStyle.wavy
                    )),
                  ),
                  Text(search_term,style: TextStyle(
                      fontSize: 50.0,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 7,
                      color: Colors.red,
                      decorationStyle: TextDecorationStyle.wavy
                  ),)
                ],
              ),
            ),
          )
        ],
      )
    );
  }
}

