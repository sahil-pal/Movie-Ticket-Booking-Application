import 'package:flutter_dotenv/flutter_dotenv.dart';

class RouteConstants{

  static String HOME = '/home';
  static String LOGIN = '/login';
  static String SIGNUP = '/signup';
  static String FORGOT_PASSWORD = '/forgotpassword';
  static String MOVIE_DETAILS = '/moviedetails';
  static String BOOKING = '/booking';
  static String PAYMENTS = '/payment';
  static String NOTIFICATION = "/notifications";
}

class AppConstants {
  static const String APP_NAME  = 'Ticket Booking';
  static const String APP_MODEL_NAME = 'Trumph';
  static const String APP_TAGLINE = 'Deals Overloaded';
  static const int SUCCESS = 1;
  static const int FAIL = 2;
}

class Collections{
  static const String EVENTS = "events";
  static const String PLAYS = "plays";
  static const String MOVIES = "movies";
  static const String THEATRES = "theatres";
  static const String USERS = "users";
  static const String DEALS = "deals";
}

class HintConstants{
  static const String CITY_HINT = "Select Your City Name";
  static const String THEATRE_HINT = "Select Theatre";
}

class SeatTypes{
  static const String TYPE1 = "Royale";
  static const String TYPE2 = "Executive";
}


