// import 'package:bigboxo_application/config/constants/api_constants.dart';
// import 'package:dio/dio.dart';
// import '../model/show.dart';


// class ShowClient{

//   Dio _dio = Dio();
  
//   // singleton approach
//   static ShowClient _showClient = ShowClient();
  
//   _ShowClient(){}
  
//   static ShowClient getShowClientInstance(){
//     // call interceptor
//     return _showClient;
//   }

//   Future<Response<dynamic>> getRecommededShows(){

//     String URL = "${ApiConstants.RapidApiBasePath}advancedsearch?start_year=2020&end_year=2022&min_imdb=6&max_imdb=10&genre&language=hindi&type=tvSeries&sort=latest&page=1";

//     Map<String,dynamic> headerParam = {
//       "X-RapidAPI-Host" : "ott-details.p.rapidapi.com",
//       "X-RapidAPI-Key" : ApiConstants.RapidApiKey
//     };
    
//     Future<Response> future = _dio.get(URL,options: Options(headers: headerParam));
//     return future;
//   }

// }