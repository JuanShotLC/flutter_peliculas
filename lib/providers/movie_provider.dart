



import 'package:flutter/material.dart';
import 'package:flutter_peliculas/models/models.dart';
import 'package:flutter_peliculas/models/popular_response.dart';
import 'package:http/http.dart' as http;


class MovieProvider extends ChangeNotifier {

  final String _apiKey    = '97cffc65c37949952832705fe3986d4d';
  final String _baseUrl   = 'api.themoviedb.org';
  final String _language  = 'es-ES';

  List<Movie> onDisplayMovies = [];
  List<Movie> popularMovies = [];

  int _popularPage = 0;

  MovieProvider(){
    print('MovieProvider inicializado');
    getOnDisplayMovies();
    getPopularMovies();
  }

  Future<String> _getJsonData( String endPoint, [int page = 1] ) async{
          var url =
        Uri.https( _baseUrl, endPoint, { 
          'api_key'  : _apiKey,
          'language' : _language,
          'page' : '$page'
          });

      final response = await http.get(url);
      return response.body;

  }
  
  getOnDisplayMovies() async {

      final jsonData = await _getJsonData('3/movie/now_playing');
      final nowPlayingResponse = NowPlayingResponse.fromJson(jsonData);

      onDisplayMovies = nowPlayingResponse.results;

      notifyListeners();
  }
    
  getPopularMovies() async{


      _popularPage++;

      final jsonData = await _getJsonData('3/movie/popular', 1 );
      final popularResponse = PopularResponse.fromJson(jsonData);

      popularMovies = [...popularMovies, ...popularResponse.results ];
      notifyListeners();
  }

}