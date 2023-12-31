
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_application_themovie/domain/api_client/api_client.dart';
import 'package:flutter_application_themovie/domain/entity/popular_movie_response.dart';
import 'package:intl/intl.dart';

import '../../domain/entity/movie.dart';
import '../../ui/navigation/main_navigation.dart';

class MovieListModel extends ChangeNotifier{
  final _apiClient = ApiClient();
  final _movies = <Movie>[];
  late int _currentPage;
  late int _totalPage;
  var _isLoadingInProgres = false;
  String? _searchQuery;
  Timer? searchDeboubce;
  List<Movie> get movies => List.unmodifiable(_movies);
 late DateFormat _dateFormat;
  String _locale ='';

  String stringFromDate(DateTime? date) => date != null ? _dateFormat.format(date) : '';
  
   Future<void> setupLocale(BuildContext context) async{
    final locale = Localizations.localeOf(context).toLanguageTag();
    if(_locale == locale) return;
    _locale = locale;
    _dateFormat = DateFormat.yMMMMd(locale);
    await _resetList();
   


  }
  Future<void> _resetList() async {
     _currentPage = 0;
    _totalPage = 1;
    _movies.clear();
    await _loadNextPage();

  }
  Future<PopularMovieResponse> _loadMovies(int nextPage, String locale) async{
    final query = _searchQuery;
    if(query == null ){
      return await _apiClient.popularMovie(nextPage, _locale);
    } else{
      return await _apiClient.searchMovie(nextPage, locale, query);
    }

  }

  Future<void> _loadNextPage() async{
    if(_isLoadingInProgres || _currentPage >= _totalPage) return;
    _isLoadingInProgres = true;
    final nextPage = _currentPage + 1;

    try {
       final moviesResponse = await _loadMovies(nextPage, _locale);
    _movies.addAll(moviesResponse.movies);
    _currentPage = moviesResponse.page;
    _totalPage = moviesResponse.totalPages;
    _isLoadingInProgres = false;
     notifyListeners();  
    } catch (e) {
      _isLoadingInProgres = false;
    }
   
   
  }

  void onMovieTab(BuildContext context, int index){
    final id = _movies[index].id;
    Navigator.of(context).pushNamed(MainNavigationRoutesNames.movieDetails, arguments: id);

  }

  Future<void> searchMovie(String text)async {
    searchDeboubce?.cancel();
    searchDeboubce = Timer(const Duration(microseconds: 300), () async 
    {final searchQuery = text.isNotEmpty ? text : null;
    if(_searchQuery == searchQuery) return;
    _searchQuery = searchQuery;
    await _resetList();
 });
    
  }

  void showedMovieAtIndex(int index){
    if(index < movies.length -1) return;
    _loadNextPage();
  }
}