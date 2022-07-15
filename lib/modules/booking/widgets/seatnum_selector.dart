import 'package:bigboxo_application/config/themes/mytheme.dart';
import 'package:bigboxo_application/modules/booking/widgets/booking_skeleton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import '../cubit/booking_cubit.dart';
import '../cubit/booking_state.dart';

class NumberOfSeatSelector extends StatelessWidget {
  
  late Size deviceSize;
  final Map<int,String> seatNum = {
    1:'bicycle.svg',2:'vespa.svg',3:'threewheeler.svg',4:'sedan.svg',5:'car.svg'
  };
  late BookingCubit bookingCubit;
  late List<dynamic> props;

  @override
  Widget build(BuildContext context) {

    deviceSize = MediaQuery.of(context).size;
    bookingCubit = BlocProvider.of<BookingCubit>(context);

    return BlocBuilder<BookingCubit,BookingState>(
      builder: ((context, state) {
        if (state is IntialBookState || state is DateAndSeatNumSelection) {
          props = state.props.toList();
          return _printSeatNum(state: state);
        } 
        else{
          return Container();
        }
      }),
    );
  }

  _printSeatNum({required BookingState state}) {
    int selectedIndex = props[0];
    return Container(
          padding: EdgeInsets.all(deviceSize.width*0.06),
          color: Colors.white,
          height: deviceSize.height*0.48,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('How Many Seats ?',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold)),
              
              Align(
                alignment: Alignment.center,
                child: SizedBox(
                  height: deviceSize.height*0.25,
                  width: deviceSize.width*0.5,
                  child: SvgPicture.asset(
                    'assets/icons/${seatNum[selectedIndex]}'
                  ),
                ),
              ),
              Container(
                height: deviceSize.height*0.06,
                child: ListView.builder(
                itemCount: 5,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: (){
                      bookingCubit.selectNumOfSeat(index+1);
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical : deviceSize.width*0.02,horizontal: deviceSize.width*0.06),
                      margin: EdgeInsets.all(deviceSize.width*0.009),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: ((selectedIndex-1) == index)
                          ? Colors.teal.shade500
                          : Colors.transparent,
                      ),
                      child: Center(
                        child: Text(
                          (index+1).toString(),
                          style : (index == selectedIndex-1)
                          ? const TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold)
                          : const TextStyle(color: Colors.black,fontSize: 16)
                        ),
                      )
                    ),
                  );
                }),
              ),
              (state is DateAndSeatNumSelection) 
              ? _printTicketTypes(props[2].ticketType)
              : const SizedBox(height: 1)
            ],
          ),
    );
  }

  _printTicketTypes(Map<String,dynamic> ticketTypes){
    DateTime currentDate = DateTime.now().add(Duration(days: props[1]));
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        (currentDate.weekday > 5) 
        ? _getColumn('Executive',ticketTypes['weekend'][0])
        : _getColumn('Executive',ticketTypes['weekday'][0]),
        SizedBox(width: deviceSize.width*0.1,),
        (currentDate.weekday > 5) 
        ? _getColumn('Royale',ticketTypes['weekend'][1])
        : _getColumn('Royale',ticketTypes['weekday'][1]),
      ],
    );
  }

  _getColumn(String heading,String value){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          heading.toUpperCase(),
          style: const TextStyle(color: Colors.grey,fontWeight: FontWeight.w900),
        ),
        Text(
          '₹ $value',
          style: const TextStyle(fontSize: 18,fontWeight: FontWeight.w500),
        )
      ],
    );
  }

}