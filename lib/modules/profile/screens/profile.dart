import 'package:bigboxo_application/config/constants/asset_path.dart';
import 'package:bigboxo_application/config/themes/mytheme.dart';
import 'package:bigboxo_application/core/auth/bloc/auth_bloc.dart';
import 'package:bigboxo_application/core/auth/bloc/auth_event.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileScreen extends StatelessWidget {

  late AuthBloc authBloc;
  late Size deviceSize;

  @override
  Widget build(BuildContext context) {
    authBloc = BlocProvider.of<AuthBloc>(context);
    deviceSize = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        _printProfilePhoto(),
        const SizedBox(height: 10,),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _printSingleRow(heading: 'Email Id', value: FirebaseAuth.instance.currentUser!.email!),
            _printSingleRow(heading: 'Name', value: 'Test User'),
            _printSingleRow(heading: 'Phone Number', value: '9999888877'),
          ],
        ),
        SizedBox(height: deviceSize.height*0.2),
        _printLogoutButton(),
      ],
    );
  }

  _printProfilePhoto() {
    return Stack(
      children: [
        Container(
          height: deviceSize.height * 0.3,
          width: deviceSize.width
        ),
        Container(
          height: deviceSize.height * 0.2,
          width: deviceSize.width,
          decoration: BoxDecoration(
              color: Colors.blueGrey.shade600,
              borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30))),
          child: Center(
              child: SvgPicture.asset('assets/icons/bigboxo-splash.svg')),
        ),
        Positioned(
          right: 10,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.orangeAccent,
              elevation: 0
            ),
            onPressed: (){},
            child: Row(
              children: [
                Text('Edit'.toUpperCase()),
                const SizedBox(width: 5,),
                const Icon(Icons.mode_edit_outline)
              ],
            ))
        ),
        Positioned(
          top: deviceSize.height * 0.2/1.5,
          left:  deviceSize.width/3.2,
          child: Container(
            height: deviceSize.height*0.16,
            width: deviceSize.width*0.4,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: NetworkImage(AssetPath.DUMMY_AVATAR),
              )
            ),
          ),
        )
      ],
    );
  }

  _printSingleRow({required String heading,required String value}){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _getContainer(text: heading, color: Colors.grey.shade500),
        _getContainer(text: value, color: Colors.grey.shade200)
      ],
    );
  }

  _getContainer({required String text,required Color color}){
    return Container(
      padding: const EdgeInsets.all(10),
      height: deviceSize.height*0.06,
      width: deviceSize.width*0.4,
      color: color,
      child: Text(text,style: GoogleFonts.cabin(fontSize: 18)),
    );
  }

  
  _printLogoutButton(){
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: Colors.red
      ),
      onPressed: (){
        authBloc.add(SignOutRequested());
      }, 
      child: Text(
        'Logout'.toUpperCase(),
         style: MyTheme.currentTheme.textTheme.bodyMedium
       )
    );
  }
}
