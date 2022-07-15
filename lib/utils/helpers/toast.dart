import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

printOnToastBar(String message, BuildContext context,int code) async{
  await Flushbar(
    title: 'BigBoxo Application',
    message: message,
    duration: Duration(seconds: 3),
    backgroundColor: (code == 1) ? Colors.green.shade400 : Colors.red.shade700,
    titleColor: Colors.black,
    borderRadius: BorderRadius.circular(20),
    margin: EdgeInsets.all(10),
  ).show(context);
}


