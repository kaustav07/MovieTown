import 'dart:math';
import 'dart:ui';

import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movie_playground/models/movieModel.dart';
import 'package:flutter_movie_playground/scopedModels/AppState.dart';
import 'package:flutter_movie_playground/services/services.dart';
import 'package:flutter_movie_playground/utils/Constants.dart';
import 'package:flutter_advanced_networkimage/provider.dart';
import 'package:scoped_model/scoped_model.dart';

class movieListPageState extends State<movieListPage> {
  final controller = TextEditingController();
  SearchResultPageState model;

  @override
  void initState() {
    model = SearchResultPageState(widget.movie_name);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //list_model = ScopedModel.of<SearchResultPageState>(context);
    return ScopedModel(
        model: model,
        child: ScopedModelDescendant<SearchResultPageState>(
          builder: (context, child, model) {
            return SafeArea(child: _buildList(context));
          },
        ));
  }

  Widget _buildList(BuildContext context) {
    return ScopedModel(
        model: ScopedModel.of<SearchResultPageState>(context).movieListState,
        child: ScopedModelDescendant<MovieListState>(
          builder: (context, child, model) {
            if (model.movies != null && model.movies.length > 1) {
              return Stack(
                children: <Widget>[
                  movieBackgroundWidget(movie: model.movies[0]),
                  Column(
                    children: <Widget>[
                      Hero(tag: 'search', child: _buildHeader(context)),
                      Expanded(child: movieListWidget(model))
                    ],
                  ),
                ],
              );
            } else {
              return Scaffold(
                body: Column(
                  children: <Widget>[
                    Hero(tag: 'search', child: _buildHeader(context)),
                    Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.transparent,
                      ),
                    )
                  ],
                ),
              );
            }
          },
        ));
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Material(
        type: MaterialType.canvas,
        elevation: 20.0,
        shadowColor: Colors.transparent,
        color: Colors.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16))),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Row(
            children: [
              Flexible(
                child: TextField(
                  controller: controller,
                  decoration: InputDecoration(
                    hintStyle: TextStyle(
                      color: Color.fromRGBO(211, 214, 195, 100),
                      fontSize: 20.0,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 4,
                    ),
                    border: InputBorder.none,
                    hintText: "Movie Name",
                  ),
                  onSubmitted: (text) {
                    ScopedModel.of<SearchResultPageState>(context)
                        .updateMovieSearch(text);
                  },
                ),
              ),
              IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  ScopedModel.of<SearchResultPageState>(context)
                      .updateMovieSearch(controller.text);
                },
              ),
              IconButton(
                  icon: Icon(
                    Icons.movie_filter,
                    color: Colors.blue,
                  ),
                  onPressed: () {})
            ],
          ),
        ),
      ),
    );
  }
}

class movieListPage extends StatefulWidget {
  movieListPage(this.movie_name);

  var movie_name;

  @override
  State createState() => movieListPageState();
}

class movieListWidget extends StatelessWidget {
  movieListWidget(this.listModel);

  MovieListState listModel;
  ScrollController controller = new ScrollController();
  MovieLoadMoreStatus status = MovieLoadMoreStatus.STABLE;
  CancelableOperation movieOperation;

  @override
  Widget build(BuildContext context) {
    listModel = ScopedModel.of<MovieListState>(context);
    return NotificationListener(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.85,
                  mainAxisSpacing: 15,
                  crossAxisSpacing: 10),
              padding: EdgeInsets.only(bottom: 10, top: 20),
              itemCount: listModel.movies.length,
              itemBuilder: (context, index) {
                return movieListItem(listModel.movies[index]);
              },
              scrollDirection: Axis.vertical,
              controller: controller,
              physics: AlwaysScrollableScrollPhysics(),
            ),
          ),
          Visibility(
            child: Container(
              height: 50,
              child: CircularProgressIndicator(),
            ),
            visible: listModel.showLoader,
          ),
        ],
      ),
      onNotification: onNotification,
    );
  }

  bool onNotification(ScrollNotification notification) {
    if (notification is ScrollUpdateNotification) {
      if (controller.position.maxScrollExtent > controller.offset &&
          controller.position.maxScrollExtent - controller.offset <= 50) {
        listModel.scrolledToEnd();
      }
    }
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
        onTap: () {
          Navigator.pushNamed(context, RouteNames.MOVIE_DETAILS,
              arguments: movie);
        },
        child: Hero(
          tag: 'movie_poster_${movie.id}',
          child: myListItem(movie.posterPath, movie.title, 250),
          placeholderBuilder: (context, child) {
            return Opacity(
              opacity: 0.3,
              child: child,
            );
          },
        ),
      ),
    );
  }
}

Widget myListItem(String imageUrl, String title, double height) {
  return Container(
    margin: EdgeInsets.only(right: 10),
    height: height,
    child: AspectRatio(
      aspectRatio: 0.7,
      child: Card(
        elevation: 20,
        clipBehavior: Clip.antiAlias,
        color: Colors.transparent.withOpacity(0.1),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: imageUrl != null
            ? FadeInImage(
                placeholder: AssetImage('images/placeholder.png'),
                image: AdvancedNetworkImage(ApiBaseUrls.TMDB_IMAGE + imageUrl,
                    scale: 0.85,
                    useDiskCache: true,
                    cacheRule: CacheRule(maxAge: Duration(days: 5)),
                    retryLimit: 3,
                    printError: true,
                    retryDuration: Duration(seconds: 3)),
                fit: BoxFit.fitWidth,
              )
            : Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: ExactAssetImage('images/placeholder.png'),
                        fit: BoxFit.fitWidth)),
                child: Center(
                  child: Text(
                    title,
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 6),
                  ),
                ),
              ),
      ),
    ),
  );
}

class movieBackgroundWidget extends StatelessWidget {
  const movieBackgroundWidget({Key key, this.movie}) : super(key: key);

  final Movie movie;

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
                          image: NetworkImage(
                              !movie.posterPath.contains('N/A')
                                  ? ApiBaseUrls.TMDB_IMAGE + movie.posterPath
                                  : 'https://m.media-amazon.com/images/M/MV5BNDYxNjQyMjAtNTdiOS00NGYwLWFmNTAtNThmYjU5ZGI2YTI1XkEyXkFqcGdeQXVyMTMxODk2OTU@._V1_SX300.jpg',
                              scale: 0.5),
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

class MovieHeaderWidget extends StatelessWidget {
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
                child: IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.white30.withOpacity(0.35),
                      size: 40,
                    ),
                    onPressed: () {
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
                      margin: EdgeInsets.only(left: 10, bottom: 10),
                      child: Text('Searching for...',
                          style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 5,
                              color: Colors.blue,
                              decorationStyle: TextDecorationStyle.wavy)),
                    ),
                    Text(
                      search_term,
                      style: TextStyle(
                          fontSize: 50.0,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 7,
                          color: Colors.red,
                          decorationStyle: TextDecorationStyle.wavy),
                    )
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
