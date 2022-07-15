import 'package:bigboxo_application/config/constants/app_constants.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationService{

  static final FlutterLocalNotificationsPlugin notificationsPlugin = FlutterLocalNotificationsPlugin();

  static void intialize(BuildContext context){

    const  InitializationSettings intialSettings = InitializationSettings(
      android: AndroidInitializationSettings("@mipmap/ic_launcher")
    );

    notificationsPlugin.initialize(intialSettings, onSelectNotification: (String? route)async{
      Navigator.pushNamed(context,RouteConstants.NOTIFICATION);
    });
  }

  static void display(RemoteMessage remoteMessage)async {

    try{
      final id = DateTime.now().millisecondsSinceEpoch~/1000;

      const  NotificationDetails notificationDetails = NotificationDetails(
      android: AndroidNotificationDetails(
          "bigboxo_notification",
          "bigboxo_notification channel",
          importance: Importance.max,
          priority: Priority.high
        )
      );

      await notificationsPlugin.show(
        id,
        'BigBoxoApplication',
        'Deal Alert ', 
        notificationDetails,
        payload: "/notifications"
      );
    }on Exception catch(e){
      print(e.toString());
    }
  }
}