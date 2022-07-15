import 'package:dio/dio.dart';

import '../../../config/constants/api_constants.dart';
import '../model/movie.dart';

class MoviesClient{

  Dio _dio = Dio();
  
  // singleton approach
  static MoviesClient _movieClient = MoviesClient();
  
  _MoviesClient(){}
  
  static MoviesClient getMovieClientInstance(){
    // call interceptor
    return _movieClient;
  }

  Future<Response<dynamic>> getRecommededMovies(){
    
    String URL = "${ApiConstants.OTTApiBasePath}advancedsearch?start_year=2022&end_year=2022&min_imdb=6&max_imdb=10&genre&language=hindi&type=movie&sort=latest&page=1";

    Map<String,dynamic> headerParam = {
      "X-RapidAPI-Host" : "ott-details.p.rapidapi.com",
      "X-RapidAPI-Key" : ApiConstants.RapidApiKey
    };

    Future<Response> future = _dio.get(URL,options: Options(headers: headerParam));

    return future;
  }

}