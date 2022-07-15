import 'package:bigboxo_application/modules/payment/cubit/payment_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../config/constants/app_constants.dart';

class PaymentSuccessful extends StatelessWidget {
  const PaymentSuccessful({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: deviceSize.width,
        padding: EdgeInsets.all(deviceSize.width*0.1),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('assets/images/successfull.gif'),
            Text('Payment Successfull !',style: GoogleFonts.play(fontSize: 22,color: Colors.black,fontWeight: FontWeight.w700)),
            SizedBox(height: deviceSize.height*0.3,),
            SizedBox(
              height: deviceSize.height*0.07,
              width: deviceSize.width*0.8,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Colors.green),
                onPressed: (){
                  PaymentCubit paymentCubit = BlocProvider.of<PaymentCubit>(context);
                  paymentCubit.moveToHome(context);
                }, 
                child: Text('Go to Home',style: GoogleFonts.play(fontSize: 22,color: Colors.white,fontWeight: FontWeight.w700)),),
          )
          ],
        ),
      ),
    );
  }
}