import 'package:bigboxo_application/config/constants/app_constants.dart';
import 'package:bigboxo_application/config/themes/mytheme.dart';
import 'package:bigboxo_application/modules/booking/cubit/booking_cubit.dart';
import 'package:bigboxo_application/modules/booking/cubit/booking_state.dart';
import 'package:bigboxo_application/modules/booking/widgets/booking_skeleton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shimmer/shimmer.dart';

class SeatInfoAndPayButtons extends StatelessWidget {
  late Size deviceSize;
  late List<dynamic> props;
  late BookingCubit bookingCubit;

  SeatInfoAndPayButtons();

  @override
  Widget build(BuildContext context) {
    deviceSize = MediaQuery.of(context).size;
    bookingCubit = BlocProvider.of<BookingCubit>(context);

    return BlocBuilder<BookingCubit, BookingState>(builder: (context, state) {
      if (state is SeatSelection) {
        props = state.props.toList();
        return Container(
          height: deviceSize.height * 0.16,
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _printAmountDetails(),
              (props[1] == props[0].numOfSeats)
                  ? _printButtons(context)
                  : _printSeatSymbols()
            ],
          ),
        );
      } else {
        return const BookingScreenSkeleton();
      }
    });
  }

  _printSeatSymbols() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _getContainer(Colors.grey),
        _getTextBox('Sold'),
        _getContainer(Colors.green),
        _getContainer(Colors.redAccent),
        _getTextBox('Selected'),
        _getBorderedContainer(Colors.green),
        _getBorderedContainer(Colors.redAccent),
        _getTextBox('Available'),
      ],
    );
  }

  _printAmountDetails() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [_getNumOfSeatRequired(), _getAmount()],
    );
  }

  _getContainer(Color color) {
    return Container(
      width: 25,
      height: 25,
      color: color,
    );
  }

  _getBorderedContainer(Color color) {
    return Container(
      width: 25,
      height: 25,
      decoration: BoxDecoration(border: Border.all(color: color, width: 2)),
    );
  }

  _getTextBox(String text) {
    return Text(
      text,
      style: const TextStyle(fontSize: 14),
    );
  }

  _getNumOfSeatRequired() {
    return Container(
      height: deviceSize.height * 0.08,
      width: deviceSize.height * 0.09,
      decoration: const BoxDecoration(
          image: DecorationImage(image: AssetImage('assets/icons/seat.jpeg'))),
      child: Center(
          child: Text(
        props[0].numOfSeats.toString(),
        style: MyTheme.currentTheme.textTheme.displayMedium,
      )),
    );
  }

  _getAmount() {
    return Container(
      height: deviceSize.height * 0.055,
      width: deviceSize.width * 0.6,
      decoration: BoxDecoration(
          color: Colors.blueGrey.shade200,
          borderRadius: BorderRadius.circular(8)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Total Amount = ₹ ',
            style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w400)
          )
          ,
          Text('${calculateAmount()}',
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w400
              )
          ),
        ],
      ),
    );
  }

  String calculateAmount() {
    Map<String, String> ticketPrices = props[0].ticketPrice;
    int royaleCategorySeatCount = props[2].length;
    int executiveCategorySeatCount = props[3].length;
    int amount = (int.parse(ticketPrices[SeatTypes.TYPE1]!) * royaleCategorySeatCount +
        int.parse(ticketPrices[SeatTypes.TYPE2]!) * executiveCategorySeatCount);
    return amount.toString();
  }

  _printButtons(BuildContext ctx) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          height: deviceSize.height * 0.05,
          width: deviceSize.width * 0.45,
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: Colors.greenAccent.shade700),
              onPressed: () {
                bookingCubit.moveToPayments(ctx);
              },
              child: Center(
                child: Text(
                  'pay now'.toUpperCase(),
                  style: MyTheme.currentTheme.textTheme.displayMedium,
                )
              )
            ),
        ),
        GestureDetector(
          onTap: (){
            bookingCubit.moveToTrump(ctx);
          },
          child: Stack(children: [
            Shimmer.fromColors(
              baseColor: MyTheme.splash,
              highlightColor: Colors.white,
              loop: 15,
              child: Container(
                height: deviceSize.height * 0.05,
                width: deviceSize.width * 0.45,
                decoration: BoxDecoration(
                  color: Colors.redAccent,
                  borderRadius: BorderRadius.circular(deviceSize.width*0.01),
                ),
              ),
            ),
            Positioned(
              top: deviceSize.height*0.008,
              left: deviceSize.height*0.05,
              child: Text(AppConstants.APP_MODEL_NAME.toUpperCase(),
                  style: const TextStyle(
                      fontSize: 24,
                      color: Colors.black87,
                      fontWeight: FontWeight.w600)),
            ),
          ]),
        )
      ],
    );
  }
}
