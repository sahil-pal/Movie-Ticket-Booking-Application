import 'dart:ui';

import 'package:bigboxo_application/config/constants/app_constants.dart';
import 'package:bigboxo_application/config/themes/mytheme.dart';
import 'package:bigboxo_application/modules/booking/models/ticket.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TicketInfo extends StatelessWidget {
  
  late Ticket ticket;
  late Size deviceSize;
  late List<int> invoiceDetails; 

  TicketInfo({required this.ticket}){
    invoiceDetails = _calculateInvoiceDetails();
  }

  @override
  Widget build(BuildContext context) {
    deviceSize = MediaQuery.of(context).size;
    return Container(
      height: deviceSize.height*0.3,
      margin: EdgeInsets.all(deviceSize.height*0.008),
      padding: EdgeInsets.all(deviceSize.height*0.018),
      decoration: BoxDecoration(
        color: Colors.blueGrey.shade300,
        borderRadius: BorderRadius.circular(deviceSize.width*0.08)
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _printDetails(),
          _printInvoiceDetails(),
        ],
      ),
    );
  }

  _printDetails(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          height: deviceSize.height*0.1,
          child: Image.asset('assets/images/cinema.png')
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(ticket.movie,style: MyTheme.currentTheme.textTheme.displayMedium),
            RichText(
              text: TextSpan(
                text: 'Seats : ',
                style: const TextStyle(color: Colors.black87,fontSize: 16),
                children: ticket.seatNumbers.map((e){
                    return TextSpan(
                      text: e+" ",
                      style: TextStyle(fontWeight: FontWeight.bold)
                    );
                }).toList(),
              ),
            ),
            RichText(
              text: TextSpan(
                text: 'Date & Time : ',
                style: const TextStyle(color: Colors.black87,fontSize: 16),
                children: [
                  TextSpan(
                      text: ticket.date.trim()+", ",
                      style: TextStyle(fontWeight: FontWeight.bold)
                  ),
                  TextSpan(
                      text: ticket.time.trim(),
                      style: TextStyle(fontWeight: FontWeight.bold)
                  )
                ]
              ),
            ),
          ],
        )
      ],
    );
  }

  _printInvoiceDetails(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _getCustomText('TYPE1 - ${SeatTypes.TYPE1.toUpperCase()} : '),
            _getCustomText(invoiceDetails[0].toString()+"  X  ₹ "+ticket.ticketPrice[SeatTypes.TYPE1].toString()),
            _getCustomText("₹"+(invoiceDetails[0]*int.parse(ticket.ticketPrice[SeatTypes.TYPE1]!)).toString()),
          ],
        ),
        SizedBox(height: deviceSize.height*0.01,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _getCustomText('TYPE2 - ${SeatTypes.TYPE2.toUpperCase()} : '),
            _getCustomText(invoiceDetails[1].toString()+"  X  ₹ "+ticket.ticketPrice[SeatTypes.TYPE2].toString()),
            _getCustomText("₹"+(invoiceDetails[1]*int.parse(ticket.ticketPrice[SeatTypes.TYPE2]!)).toString()),
          ],
        ),
        SizedBox(height: deviceSize.height*0.01,),
        const Divider(color: Colors.black,height: 5,thickness: 1,endIndent: 5.0,),
        SizedBox(height: deviceSize.height*0.01,),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            _getCustomText('Total Amount = ₹'),
            _getCustomText(invoiceDetails[2].toString()),
          ],
        ),
      ],
    );
  }

  _getCustomText(String text){
    return Text(
      text,
      style: GoogleFonts.cabin(fontSize: 16,fontWeight: FontWeight.w400),
    );
  }

  List<int> _calculateInvoiceDetails(){
    Set royaleRows = {'A','B','C'};
    int royalCount = 0;
    int executiveCount = 0;
    ticket.seatNumbers.forEach((element) {
        if(royaleRows.contains(element.substring(0,1))){
          royalCount++;
        }
        else{
          executiveCount++;
        }
    });
    int totalAmount = (royalCount*int.parse(ticket.ticketPrice[SeatTypes.TYPE1]!))+(executiveCount*int.parse(ticket.ticketPrice[SeatTypes.TYPE2]!));
    List<int> info = [royalCount,executiveCount,totalAmount];
    return info;
  }
}