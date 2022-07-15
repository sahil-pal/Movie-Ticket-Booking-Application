import 'package:bigboxo_application/config/constants/app_constants.dart';
import 'package:bigboxo_application/core/auth/screens/forgot_password.dart';
import 'package:bigboxo_application/core/auth/screens/login.dart';
import 'package:bigboxo_application/core/auth/screens/signup.dart';
import 'package:bigboxo_application/modules/booking/screens/booking.dart';
import 'package:bigboxo_application/modules/details/screens/movie_detail.dart';
import 'package:bigboxo_application/modules/home/screens/home.dart';
import 'package:bigboxo_application/modules/payment/screens/payment.dart';
import 'package:bigboxo_application/modules/trump/screens/notifications.dart';
import 'package:bigboxo_application/modules/trump/screens/trump.dart';
import 'package:flutter/material.dart';

Map<String,WidgetBuilder> getRoutes(){
  return {
    // RouteConstants.SPLASH : (context) => SplashScreen(),
    RouteConstants.LOGIN : (context) => LoginScreen(),
    RouteConstants.SIGNUP :(context) => SignUpScreen(),
    RouteConstants.HOME : (context) => const HomeScreen(),
    RouteConstants.FORGOT_PASSWORD : (context) => ForgotPassword(),
    RouteConstants.MOVIE_DETAILS : (context) => MovieDetailScreen(),
    RouteConstants.BOOKING :(context) => BookingScreen(),
    RouteConstants.PAYMENTS : ((context) => const PaymentScreen()),
    RouteConstants.NOTIFICATION :(context) => NotificationScreen(),
  };
}