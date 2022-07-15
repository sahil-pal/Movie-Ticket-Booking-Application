import 'package:bigboxo_application/modules/payment/cubit/payment_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../booking/models/ticket.dart';

class PaymentMethods extends StatelessWidget {
  
  late Size deviceSize;
  late PaymentCubit paymentCubit;
  late Ticket ticket;

  PaymentMethods({required this.ticket});

  @override
  Widget build(BuildContext context) {
    deviceSize = MediaQuery.of(context).size;
    paymentCubit = BlocProvider.of<PaymentCubit>(context);
    
    return Container(
      height: deviceSize.height*0.56,
      width: deviceSize.width,
      padding: EdgeInsets.all(deviceSize.width*0.1),
      decoration: BoxDecoration(
        color: const Color.fromARGB(208, 202, 185, 28),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(deviceSize.width*0.1),
          topRight: Radius.circular(deviceSize.width*0.1)
        )
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _printCreditCard(),
          _printUPICard(),
          _printPayButton(),
        ],
      ),
    );
  }

  _printCreditCard(){
    return Container(
      height: deviceSize.height*0.2,
      width: deviceSize.width,
      padding: EdgeInsets.all(deviceSize.width*0.04),
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius: BorderRadius.circular(deviceSize.width*0.02)
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Payment Card',style: GoogleFonts.play(fontSize: 22,color: Colors.white,fontWeight: FontWeight.w700)),
              Container(height:deviceSize.height*0.08,child: Image.asset('assets/images/visa.png'))
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('xxxx xxxx xx07',style: GoogleFonts.cabin(fontSize: 20,color: Colors.white,fontWeight: FontWeight.w700)),
              Text('09/24',style: GoogleFonts.cabin(fontSize: 18,color: Colors.white,fontWeight: FontWeight.w700)),
            ],
          ),
        ],
      ),
    );
  }

  _printUPICard(){
    return Stack(
      children: [
        Container(
          height: deviceSize.height*0.2,
          width: deviceSize.width,
          padding: EdgeInsets.all(deviceSize.width*0.04),
          decoration: BoxDecoration(
            color: Colors.grey.shade600,
            borderRadius: BorderRadius.circular(deviceSize.width*0.02),
            border: Border.all(color: Colors.green,width: 5)
          ),
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('UPI',style: GoogleFonts.play(fontSize: 22,color: Colors.white,fontWeight: FontWeight.w700)),
                _getImageContainer('apple-pay'),
                _getImageContainer('google-pay'),
                _getImageContainer('amazon-pay'),
                _getImageContainer('paytm'),
              ],
            ),
            Text('testuser@upi',style: GoogleFonts.cabin(fontSize: 20,color: Colors.white,fontWeight: FontWeight.w700)),
          ],
          )
        ),
        Positioned(
            bottom: 0,
            right:0,
            child: Container(
              color: Colors.green,
              height: deviceSize.height*0.03,
              width: deviceSize.width*0.07,
              child: Image.asset('assets/images/check-mark.png'),
          )
        )

      ]
    );
  }

  _printPayButton(){
    return SizedBox(
      height: deviceSize.height*0.06,
      width: deviceSize.width*0.8,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(primary: Colors.green),
        onPressed: (){
          paymentCubit.initiatePayment(this.ticket);
        }, 
        child: Text('Pay Amount',style: GoogleFonts.play(fontSize: 22,color: Colors.white,fontWeight: FontWeight.w700)),),
    );
  }

  _getImageContainer(String name){
    return Container(
      height:deviceSize.height*0.06,
      width: deviceSize.width*0.12,
      decoration: BoxDecoration(
        //border: Border.all(color: Colors.black,width: 2),
        image: DecorationImage(image: AssetImage('assets/images/$name.png',))
      ),
    );
  }
}