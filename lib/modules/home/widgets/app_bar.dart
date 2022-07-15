import 'package:flutter/material.dart';
import '../../../config/constants/app_constants.dart';
import '../../../config/themes/mytheme.dart';

class HomeAppBar extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: MyTheme.splash,
      toolbarHeight: 50,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(AppConstants.APP_NAME.toUpperCase(),
              style: MyTheme.currentTheme.textTheme.displayLarge),
          Text(
            AppConstants.APP_TAGLINE,
            style: MyTheme.currentTheme.textTheme.bodySmall,
          )
        ],
      ),
      actions: [
        Container(
            margin: const EdgeInsets.only(right: 20),
            child: IconButton(
              onPressed: (){
                Navigator.pushNamed(context, RouteConstants.NOTIFICATION);
              },
              icon : const Icon(
                Icons.notifications_none_outlined,
                size: 25),
            ))
      ],
    );
  }
}