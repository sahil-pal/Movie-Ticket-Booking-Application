import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConstants{

  static final String RapidApiKey = dotenv.env["RAPID_API_KEY"]!;
  static final String OTTApiBasePath = dotenv.env["OTT_API_BASE_URL"]!;
  static final String MovieDetailApiBasePath = dotenv.env["MOVIE_DETAIL_API_BASE_URL"]!;
  static final String BigBoxoServer = dotenv.env["BIG_BOXO_SERVER_PROD"]!;
  
}