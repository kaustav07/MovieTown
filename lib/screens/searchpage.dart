import 'package:flutter/material.dart';
import 'package:flutter_movie_playground/models/movieModel.dart';
import 'package:flutter_movie_playground/screens/movielistpage.dart';
import 'package:flutter_movie_playground/utils/Constants.dart';

class searchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        elevation: 10,
        title: Container(
          margin: EdgeInsets.only(bottom: 20),
          child: Text(
            Constants.APP_NAME,
            style: TextStyle(
                letterSpacing: 7, fontSize: 30, fontWeight: FontWeight.w600),
          ),
        ),
      ),
      body: EmptySearchPage(),
    );
  }
}

class EmptySearchPage extends StatefulWidget {
  @override
  State createState() => EmptySearchPageState();
}

class EmptySearchPageState extends State<EmptySearchPage> {
  EmptySearchPageState({this.movie_name});

  String movie_name;

  @override
  Widget build(BuildContext context) {
    if (movie_name == null)
      return Scaffold(
          body: Hero(
              tag: 'search',
              child: Material(
                type: MaterialType.canvas,
                elevation: 20.0,
                shadowColor: Colors.transparent,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(16),
                        bottomRight: Radius.circular(16))),
                child: Container(
                    child: Padding(
                        padding: EdgeInsets.all(25),
                        child: Center(
                            child: TextField(
                          decoration: InputDecoration(
                            hintStyle: TextStyle(
                                color: Color.fromRGBO(211, 214, 195, 100),
                                fontSize: 50.0,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 6),
                            hintText: "Movie Name",
                          ),
                          onSubmitted: (name) {
                            redirectToListPage(context, name);
                          },
                          textInputAction: TextInputAction.go,
                          cursorColor: Colors.transparent,
                          keyboardType: TextInputType.text,
                          style: TextStyle(
                              fontSize: 50.0,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w600,
                              color: Colors.black),
                          textAlign: TextAlign.center,
                          textCapitalization: TextCapitalization.words,
                        )))),
              )));
  }

  void redirectToListPage(BuildContext context, String name) {
    Navigator.pushNamed(context, RouteNames.MOVIE_LIST,
        arguments: new MovieListPageArgs(movie_name: name));
  }
}
