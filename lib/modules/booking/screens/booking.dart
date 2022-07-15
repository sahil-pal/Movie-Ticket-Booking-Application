import 'package:bigboxo_application/modules/booking/cubit/booking_cubit.dart';
import 'package:bigboxo_application/modules/booking/cubit/booking_state.dart';
import 'package:bigboxo_application/modules/booking/widgets/appbar.dart';
import 'package:bigboxo_application/modules/booking/widgets/booking_skeleton.dart';
import 'package:bigboxo_application/modules/booking/widgets/date_selector.dart';
import 'package:bigboxo_application/modules/booking/widgets/seat_selector.dart';
import 'package:bigboxo_application/modules/booking/widgets/seatinfo_and_paybtns.dart';
import 'package:bigboxo_application/modules/booking/widgets/seatnum_selector.dart';
import 'package:bigboxo_application/modules/booking/widgets/time_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../config/themes/mytheme.dart';

class BookingScreen extends StatelessWidget {
  
  late Size deviceSize;
  late BookingCubit bookingCubit;

  @override
  Widget build(BuildContext context) {
    deviceSize = MediaQuery.of(context).size;
    Map arguments = ModalRoute.of(context)!.settings.arguments as Map;
    bookingCubit = BlocProvider.of<BookingCubit>(context);

    return BlocBuilder<BookingCubit, BookingState>(
      builder: ((context, state) {
        if (state is LoadingState) {
          return BookingScreenSkeleton();
        } 
        else if(state is IntialBookState || state is DateAndSeatNumSelection){
          return Scaffold(
            backgroundColor: Colors.grey.shade100,
            appBar: PreferredSize(
              preferredSize: Size(deviceSize.width, deviceSize.height * 0.08),
              child: BookingAppBar(
                title: arguments['movieName'],
                theatreName: arguments['theatreName'],
              ),
            ),
            body: SafeArea(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(height: 5,),
                DateSelector(arguments['theatreName'],arguments['movieName']),
                const Divider(height: 1),
                ShowTimeSelector(),
                const Divider(height: 1),
                NumberOfSeatSelector(),
                _getSeatSelectionButton(),
                const SizedBox(height: 5,),
              ],
            )),
          );
        }
        else if(state is SeatSelection){
          return Scaffold(
            backgroundColor: Colors.grey.shade100,
            appBar: PreferredSize(
              preferredSize: Size(deviceSize.width, deviceSize.height * 0.08),
              child: BookingAppBar(
                title: arguments['movieName'],
                theatreName: arguments['theatreName'],
              ),
            ),
            body: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height:deviceSize.height*0.01,),
                  SeatSelectionWidget(),
                  SeatInfoAndPayButtons()
                ],
            )),
          );
        }
        else if(state is LoadingError){
          List<dynamic> props = state.props.toList();
          return Scaffold(body: Center(child: Text(props[0].toString())));
        }
        return Container();
        
      }),
    );
  }

  _getSeatSelectionButton() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: SizedBox(
        height: deviceSize.height * 0.06,
        width: deviceSize.width*0.7,
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(primary: MyTheme.splash),
            onPressed: () {
              bookingCubit.moveToSeatSelection();
            },
            child: Text(
              'Select Seats'.toUpperCase(),
              style: MyTheme.currentTheme.textTheme.displayMedium,
            )),
      ),
    );
  }
}
