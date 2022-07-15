import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyTheme {

  static final currentTheme = myLightTheme;
  
  static const home = Color(0xFF80CBC4);
  static const splash = Color.fromARGB(229, 223, 24, 41);
  static const appBarColor = Color(0xFF222539);
  static const greenColor = Color(0xFF2EC492);
  static const orangeColor = Color(0xFFEB8D2F);
  static const greyColor = Color(0xFFF4F4F4);
  static const blueBorder = Color(0xFF3164CE);
  static const redBorder = Color(0xFFF14336);
  static const redLight = Color(0xFFFFF1F0);
  static const blueLight = Color(0xFFF5F9FF);
 
  static final BigBoxoText = GoogleFonts.oswald(
    fontSize : 30,
    fontWeight: FontWeight.bold,
    letterSpacing: 1,
    color: Colors.white
  );

  static final DescriptionText = GoogleFonts.oswald(
    fontSize : 15,fontWeight: FontWeight.bold,letterSpacing: 1,color: Colors.green
  );

  static final myLightTheme = ThemeData(
    primaryColor: splash,
    scaffoldBackgroundColor: Colors.white,
    textTheme:  TextTheme(
      headline1: const TextStyle(fontSize: 25,color: Colors.white,fontWeight: FontWeight.w600),
      headline2: const TextStyle(fontSize: 23,color: Colors.white,fontWeight: FontWeight.w600),
      headline3: const TextStyle(fontSize: 15,color: Colors.black,fontWeight: FontWeight.bold),
      headline4: const TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.w600),
      headline5: const TextStyle(fontSize: 16,color: Colors.black,fontWeight: FontWeight.w700),
      headline6: const TextStyle(fontSize: 14,fontWeight: FontWeight.w700,color: Colors.black),
    ),
    brightness: Brightness.light,
    backgroundColor: Colors.white,
    fontFamily: 'Poppins',
    buttonTheme: const ButtonThemeData(
      colorScheme: ColorScheme.light(
        background: splash,
        primary: splash,
      ),
    ),
    appBarTheme: const AppBarTheme(
      color: appBarColor,
    ),
  );

  static final myDarkTheme = ThemeData(
    primaryColor: splash,
    scaffoldBackgroundColor: appBarColor,
    fontFamily: 'Poppins',
    brightness: Brightness.dark,
    backgroundColor: appBarColor,
    buttonTheme: const ButtonThemeData(
      colorScheme: ColorScheme.dark(
        background: splash,
        primary: splash,
      ),
    ),
    appBarTheme: const AppBarTheme(
      color: appBarColor,
    ),
  );
}