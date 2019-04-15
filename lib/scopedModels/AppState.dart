import 'package:async/async.dart';
import 'package:flutter_movie_playground/models/movieModel.dart';
import 'package:flutter_movie_playground/services/services.dart';
import 'package:scoped_model/scoped_model.dart';

class GlobalAppState extends Model {}

class SearchPageState extends Model {}

class SearchResultPageState extends Model {
  SearchResultPageState(this._search_term) {
    movieListState = MovieListState(search_term);
    fetchMoviesForSearchTerm();
  }

  var _search_term;
  MovieListState movieListState;

  get search_term => _search_term;

  updateMovieSearch(String text){
    _search_term = text;
    movieListState.clear();
    fetchMoviesForSearchTerm();
    notifyListeners();
  }

  fetchMoviesForSearchTerm() async {
    var response = await getMoviesv2(search_term).then((response) {
      return response;
    });
    movieListState.currentPageNumber = response.page;
    movieListState.totalPages = response.totalPages;
    movieListState.addMovies(response.results);
  }
}

class MovieListState extends Model {
  MovieListState(this.search_term,{this.movies, this.currentPageNumber, this.totalPages});

  List<Movie> movies = List();
  int currentPageNumber;
  int totalPages;
  bool _showLoader = false;
  String search_term;
  CancelableOperation movieOperation;

  bool get showLoader => _showLoader;

  clear(){
    movies.clear();
    currentPageNumber = 0;
    totalPages = 0;
    _showLoader = false;
    movieOperation = null;
  }

  addMovies(List<Movie> moreMovies) {
    if (movies == null)
      movies = moreMovies;
    else {
      movies.addAll(moreMovies);
    }
    if (_showLoader) _showLoader = false;
    notifyListeners();
  }

  scrolledToEnd(){
    if(!_showLoader && currentPageNumber < totalPages){
      _showLoader = true;
      notifyListeners();
      _getMoviesForNextPage();
    }
  }

  _getMoviesForNextPage() async {
    movieOperation = CancelableOperation.fromFuture(
        getMoviesv2(search_term, currentPageNumber: currentPageNumber + 1)
            .then((object) {
      currentPageNumber = object.page;
      addMovies(object.results);
    }));
  }

  dispose() {
    movieOperation?.cancel();
  }
}

enum MovieLoadMoreStatus { LOADING, STABLE }
