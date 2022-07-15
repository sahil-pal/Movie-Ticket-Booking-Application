import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../config/constants/app_constants.dart';
import '../../../config/themes/mytheme.dart';

class SplashScreen extends StatelessWidget {
  
  Widget nextScreen;
  SplashScreen(this.nextScreen);

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      backgroundColor: MyTheme.splash,
      splash: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Text(AppConstants.APP_NAME,style: MyTheme.BigBoxoText),
          SvgPicture.asset(
            "assets/splash/bigboxo-splash.svg",
            height: 100,
            color: Colors.white,
          ),
        ],
      ),
      duration: 3000,
      nextScreen: nextScreen,
      splashTransition: SplashTransition.fadeTransition,
    );
  }
}