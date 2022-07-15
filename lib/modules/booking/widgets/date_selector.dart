import 'package:bigboxo_application/config/themes/mytheme.dart';
import 'package:bigboxo_application/modules/booking/cubit/booking_cubit.dart';
import 'package:bigboxo_application/modules/booking/cubit/booking_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DateSelector extends StatelessWidget {
  
  late Size DeviceSize;
  final Map<int,String> weekDay = {
    1:'MON',2:'TUE',3:'WED',4:'THU',5:'FRI',6:'SAT',7:'SUN'
  };
  final Map<int,String> month = {
    1:'JAN',2:'FEB',3:'MAR',4:'APR',5:'MAY',6:'JUN',7:'JUL',8:'AUG',9:'SEP',10:'OCT',11:'NOV',12:'DEC'
  };
  late BookingCubit bookingCubit;
  late String theatreName;
  late String movieName;

  DateSelector(this.theatreName,this.movieName);

  @override
  Widget build(BuildContext context) {

    DeviceSize = MediaQuery.of(context).size;
    bookingCubit = BlocProvider.of<BookingCubit>(context);

    return BlocBuilder<BookingCubit, BookingState>(
      builder: ((context, state) {
        if (state is IntialBookState || state is DateAndSeatNumSelection) {
          List<dynamic> props = state.props.toList();
          return _printDates(selectedIndex : props[1] ?? 0);
        } else {
          return Container();
        }
      }),
    );
  }

  _printDates({required int selectedIndex}) {
    DateTime currentDate = DateTime.now();
    return Container(
          color: Colors.white,
          height: DeviceSize.height*0.14,
          child: ListView.builder(
          itemCount: 7,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            var date = currentDate.add(Duration(days: index));
            return 
            (index < 3) ?
            GestureDetector(
              onTap: (){
                print("index pressed ==> "+index.toString());
                bookingCubit.selectDate(index,theatreName,movieName);
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical : DeviceSize.width*0.05,horizontal: DeviceSize.width*0.05),
                margin: EdgeInsets.all(DeviceSize.width*0.005),
                decoration: BoxDecoration(
                  color: (selectedIndex == index)
                    ? Colors.teal.shade500
                    : Colors.transparent,
                    borderRadius: BorderRadius.circular(5),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      weekDay[date.weekday].toString(),
                      style : (index == selectedIndex)
                        ? const TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.bold)
                        : const TextStyle(color: Colors.black,fontSize: 14)
                    ),
                    Text(
                      date.day.toString(),
                      style : (index == selectedIndex)
                        ? const TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold)
                        : MyTheme.currentTheme.textTheme.displaySmall
                    ),
                    Text(
                      month[date.month].toString(),
                      style : (index == selectedIndex)
                        ? const TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.bold)
                        : const TextStyle(color: Colors.black,fontSize: 14)
                    )
                  ],
                )
              ),
            )
            : 
            Container(
              padding: EdgeInsets.all(DeviceSize.width*0.05),
              margin: EdgeInsets.all(DeviceSize.width*0.005),
              decoration: BoxDecoration(
                color: Colors.grey.shade400.withOpacity(0.3), 
                borderRadius: BorderRadius.circular(5),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _getFadedTextBox(weekDay[date.weekday].toString()),
                  _getFadedTextBox(date.day.toString()),
                  _getFadedTextBox(month[date.month].toString()),
                ],
              )
            );
          }),
    );
  }

  Text _getFadedTextBox(String text){
    return Text(
      text,
      style: const TextStyle(fontWeight: FontWeight.w300)
    );
  }

}
