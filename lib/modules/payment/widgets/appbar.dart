import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../config/themes/mytheme.dart';

class PaymentAppBar extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return AppBar(
      elevation: 0,
      backgroundColor: MyTheme.splash,
      leading: IconButton(
        onPressed: (){
          Navigator.pop(context);
        },
        icon: const Icon(Icons.arrow_back_ios_new)
      ),
       title: Text('pay here'.toUpperCase(),
              style: GoogleFonts.play(fontSize: 22,letterSpacing: 0.5),
      )
    );
  }
}