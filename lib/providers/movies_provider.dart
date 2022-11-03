import 'dart:convert';


import 'package:dspeliculas/models/now_playng_response.dart';
import 'package:dspeliculas/models/popular_response.dart';
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
}