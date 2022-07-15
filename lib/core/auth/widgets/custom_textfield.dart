import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  
  late TextEditingController txtcontroller;
  late String hintText;
  late bool isObsecure;
  late IconData iconData;

  CustomTextField({required this.txtcontroller,required this.hintText,required this.iconData,this.isObsecure = false});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        obscureText: isObsecure,
        controller: txtcontroller,
        style: const TextStyle(color: Colors.black),
            decoration: InputDecoration(
              prefixIcon : Icon(iconData,color: Colors.grey.shade700,),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide.none,
              ),
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.black45),
        //fillColor: MyTheme.greyColor,
        filled: true,
      ),
    );
  }
}