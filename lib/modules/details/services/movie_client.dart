import 'package:dio/dio.dart';
import '../../../config/constants/api_constants.dart';

class MoviesClient{

  Dio _dio = Dio();
  
  // singleton approach
  static MoviesClient _movieClient = MoviesClient();
  
  _MoviesClient(){}
  
  static MoviesClient getMovieClientInstance(){
    // call interceptor
    return _movieClient;
  }

  Future<Response<dynamic>> getMovieDetail({required String imdbID}){
    String URL = '${ApiConstants.MovieDetailApiBasePath}?i=$imdbID';

    Map<String,dynamic> headerParam = {
      "X-RapidAPI-Host" : "mdblist.p.rapidapi.com",
      "X-RapidAPI-Key" : ApiConstants.RapidApiKey
    };

    Future<Response> future = _dio.get(URL,options: Options(headers: headerParam));

    return future;
  }

}