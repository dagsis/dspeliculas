import 'dart:async';
import 'dart:convert';


import 'package:dspeliculas/helpers/debource.dart';
import 'package:dspeliculas/models/now_playng_response.dart';
import 'package:dspeliculas/models/popular_response.dart';
import 'package:dspeliculas/models/search_movie_response.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/credits_response.dart';
import '../models/movie.dart';

class MoviesProviders extends ChangeNotifier {

  String _apiKey = 'fdf9d3238ba35bbffc0acac694344551';
  String _baseUrl = 'api.themoviedb.org';
  String _languaje = 'es-ES';

  List<Movie> onDisplayMovies = [];
  List<Movie> popularMovies = [];

  Map<int,List<Cast>> movieCast = {};

  int _popularPage = 0;

  final debouncer = Debouncer(
      duration: Duration(milliseconds: 500));

  final StreamController<List<Movie>>_suggestionStreamController = new StreamController.broadcast();
  Stream<List<Movie>>get suggestionStream => this._suggestionStreamController.stream;

  MoviesProviders() {

    this.getOnDisplayMovies();
    this.getPopularMovies();
  }

  Future<String> _getJsonData(String endpoing,[int page = 1]) async {
    var url =  Uri.https(_baseUrl,endpoing,{
      'api_key' : _apiKey,
      'language' :_languaje,
      'page' : '$page'
    });

    final response = await http.get(url);
    return response.body;
  }

  getOnDisplayMovies() async {

    final jsonData = await this._getJsonData('3/movie/now_playing');
    final nowPlayResponse = NowPlayngResponse.fromJson(jsonData);

    onDisplayMovies = nowPlayResponse.results;
    notifyListeners();
  }

  getPopularMovies() async {

    _popularPage++;

    final jsonData = await this._getJsonData('3/movie/popular',_popularPage);
    final popularResponse = PopularResponse.fromJson(jsonData);

    popularMovies = [...popularMovies, ...popularResponse.results];
    notifyListeners();
  }

   Future<List<Cast>> getMovieCast(int movieId) async {

    if (movieCast.containsKey(movieId)) return movieCast[movieId]!;

     final jsonData = await this._getJsonData('3/movie/${movieId}/credits');
     final creditResponse = CreditsResponse.fromJson(jsonData);

     movieCast[movieId] = creditResponse.cast;

     return creditResponse.cast;
  }

  Future<List<Movie>>  searchMovie(String query) async {
    final url =  Uri.https(_baseUrl,'3/search/movie',{
      'api_key' : _apiKey,
      'language' :_languaje,
      'query' : query
    });

    final response = await http.get(url);
    final searchResponse = SearchMoviesResponse.fromJson(response.body);

    return searchResponse.results;
  }

  void getSuggestionByQuery(String seachTerm) {
     debouncer.value = '';
     debouncer.onValue = (value) async {
       final results = await this.searchMovie(value);
       this._suggestionStreamController.add(results);
     };

     final timer = Timer.periodic(Duration(milliseconds: 300), (_) {
       debouncer.value = seachTerm;
     });
     
     Future.delayed(Duration(milliseconds: 301)).then((_) => timer.cancel());

  }

}