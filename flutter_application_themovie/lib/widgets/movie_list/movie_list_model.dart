
import 'package:flutter/material.dart';
import 'package:flutter_application_themovie/domain/api_client/api_client.dart';
import 'package:intl/intl.dart';

import '../../domain/entity/movie.dart';
import '../../ui/navigation/main_navigation.dart';

class MovieListModel extends ChangeNotifier{
  final _apiClient = ApiClient();
  final _movies = <Movie>[];
  List<Movie> get movies => List.unmodifiable(_movies);
 late DateFormat _dateFormat;
  String _locale ='';

  String stringFromDate(DateTime? date) => date != null ? _dateFormat.format(date) : '';
  
  void setupLocale(BuildContext context){
    final locale = Localizations.localeOf(context).toLanguageTag();
    if(_locale == locale) return;
    _locale = locale;
    _dateFormat = DateFormat.yMMMMd(locale);
    _movies.clear();
    _loadMovies();


  }

  Future<void> _loadMovies() async{
    final moviesResponse = await _apiClient.popularMovie(1, _locale);
    _movies.addAll(moviesResponse.movies);
    notifyListeners();
  }

  void onMovieTab(BuildContext context, int index){
    final id = _movies[index].id;
    Navigator.of(context).pushNamed(MainNavigationRoutesNames.movieDetails, arguments: id);

  }
}