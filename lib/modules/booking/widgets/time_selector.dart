import 'package:bigboxo_application/config/themes/mytheme.dart';
import 'package:bigboxo_application/modules/booking/cubit/booking_cubit.dart';
import 'package:bigboxo_application/modules/booking/cubit/booking_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShowTimeSelector extends StatelessWidget {
  
  late Size DeviceSize;
  late BookingCubit bookingCubit;
  late  List<dynamic> props;
  
  @override
  Widget build(BuildContext context) {

    DeviceSize = MediaQuery.of(context).size;
    bookingCubit = BlocProvider.of<BookingCubit>(context);

    return BlocBuilder<BookingCubit, BookingState>(
      builder: ((context, state) {
        if (state is DateAndSeatNumSelection) {
          props = state.props.toList();
          return _printTimings(selectedIndex : props[3]);
        } else {
          return Container();
        }
      }),
    );
  }

  _printTimings({required int selectedIndex}) {
    return Container(
          color: Colors.white,
          height: DeviceSize.height*0.14,
          child: ListView.builder(
          itemCount: props[4].length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: (){
                bookingCubit.selectShowTiming(index);
              },
              child: Container(
                width: DeviceSize.width*0.175,
                padding: EdgeInsets.symmetric(vertical : DeviceSize.width*0.02,horizontal: DeviceSize.width*0.02),
                margin: EdgeInsets.all(DeviceSize.width*0.005),
                decoration: BoxDecoration(
                  color: (selectedIndex == index)
                    ? Colors.teal.shade500
                    : Colors.transparent,
                    borderRadius: BorderRadius.circular(5),
                ),
                child: Center(
                  child: Text(
                    props[4][index],
                    style : (index == selectedIndex)
                        ? const TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold)
                        : const TextStyle(color: Colors.black,fontSize: 14)
                  ),
                )
              ),
            );
          }),
    );
  }

}
