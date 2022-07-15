import 'package:bigboxo_application/config/constants/app_constants.dart';
import 'package:bigboxo_application/config/themes/mytheme.dart';
import 'package:bigboxo_application/modules/booking/cubit/booking_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import '../cubit/booking_cubit.dart';

class SeatSelectionWidget extends StatelessWidget {
  late Size deviceSize;
  late BookingCubit bookingCubit;
  late List<dynamic> props;
  Set seatGapRoyale = {28, 47};
  Set seatGapExecutive = {1, 10, 19};

  @override
  Widget build(BuildContext context) {
    deviceSize = MediaQuery.of(context).size;
    bookingCubit = BlocProvider.of<BookingCubit>(context);
    return BlocBuilder<BookingCubit, BookingState>(builder: (context, state) {
      if (state is SeatSelection) {
        props = state.props.toList();
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Container(
            padding: EdgeInsets.symmetric(
                horizontal: deviceSize.width * 0.02,
                vertical: deviceSize.width * 0.02),
            color: Colors.white,
            height: deviceSize.height * 0.7,
            width: deviceSize.width * 1.66,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: deviceSize.width * 0.03,
                      height: deviceSize.height * 0.17,
                      padding: EdgeInsets.only(top: deviceSize.height *0.038),
                      child: ListView.builder(
                          itemCount: 3,
                          itemBuilder: ((context, index) {
                            return Container(
                              height: 35,
                              width: 28,
                              child: Center(
                                child: Text(
                                  props[4][index],
                                  style: MyTheme.currentTheme.textTheme.displaySmall,
                                ),
                              ),
                            );
                          })),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _getHeading(
                            "${SeatTypes.TYPE1}  ₹${props[0].ticketPrice[SeatTypes.TYPE1]}"),
                        Divider(
                          height: deviceSize.height * 0.009,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: deviceSize.width * 0.02,
                              vertical: deviceSize.width * 0.02),
                          height: deviceSize.height * 0.154,
                          width: deviceSize.width * 1.58,
                          child: GridView.extent(
                              mainAxisSpacing: 5,
                              maxCrossAxisExtent: 32,
                              children: List.generate(57, (index) {
                                return (!seatGapRoyale.contains(index))
                                    ? GestureDetector(
                                        onTap: () {
                                          if(!props[5].contains(index)){
                                            if (props[1] == props[0].numOfSeats) {
                                              bookingCubit.royaleSeatRemove(index);
                                            } else {
                                              bookingCubit.royaleSeatSelected(index);
                                            }
                                          }
                                        },
                                        child: Container(
                                          padding: EdgeInsets.all(2),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            color: (props[2].contains(index))
                                                ? Colors.redAccent
                                                : (props[5].contains(index))
                                                  ? Colors.grey
                                                  : Colors.white,
                                            border: Border.all(
                                                color: (props[5].contains(index))
                                                ? Colors.grey
                                                : Colors.redAccent,
                                                width: 2),
                                          ),
                                          height: 32,
                                          width: 32,
                                          margin: EdgeInsets.all(2),
                                          child: Center(
                                              child: Text(((index % 19) + 1)
                                                  .toString())),
                                        ),
                                      )
                                    : Container(
                                        height: 32,
                                        width: 32,
                                        margin: EdgeInsets.all(2),
                                      );
                              })),
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      width: deviceSize.width * 0.03,
                      height: deviceSize.height * 0.35,
                      padding: EdgeInsets.only(top: deviceSize.height *0.03),
                      child: ListView.builder(
                          itemCount: 8,
                          itemBuilder: ((context, index) {
                            return Container(
                              height: 32,
                              width: 28,
                              child: Center(
                                child: Text(
                                  props[4][index+3],
                                  style: MyTheme.currentTheme.textTheme.displaySmall,
                                ),
                              ),
                            );
                          })),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _getHeading("${SeatTypes.TYPE2}  ₹${props[0].ticketPrice[SeatTypes.TYPE2]}"),
                        Divider(
                          height: deviceSize.height * 0.009,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: deviceSize.width * 0.02,
                              vertical: deviceSize.width * 0.02),
                          height: deviceSize.height * 0.35,
                          width: deviceSize.width * 1.55,
                          child: GridView.extent(
                              mainAxisSpacing: 1,
                              maxCrossAxisExtent: 32,
                              children: List.generate(151, (index) {
                                return (!seatGapExecutive.contains(((index % 19) + 1)))
                                    ? GestureDetector(
                                      onTap: () {
                                        if(!props[6].contains(index)){
                                          if (props[1] == props[0].numOfSeats) {
                                            bookingCubit.executiveSeatRemove(index);
                                          } else {
                                            bookingCubit.executiveSeatSelected(index);
                                          }
                                        }
                                      },
                                      child: Container(
                                          padding: const EdgeInsets.all(2),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(5),
                                            color: (props[3].contains(index))
                                                ? Colors.green
                                                : (props[6].contains(index))
                                                  ? Colors.grey
                                                  : Colors.white,
                                            border:Border.all(
                                              color: (props[6].contains(index))
                                                  ? Colors.grey
                                                  : Colors.green,
                                              width: 2),
                                          ),
                                          height: 32,
                                          width: 32,
                                          margin: const EdgeInsets.all(2),
                                          child: Center(
                                              child: Text(((index % 19) + 1).toString())),
                                        ),
                                    )
                                    : Container(
                                        height: 30,
                                        width: 30,
                                        margin: const EdgeInsets.all(2),
                                      );
                              })),
                        ),
                      ],
                    ),
                  ],
                ),
                
                SizedBox(height: deviceSize.height * 0.03),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    _getExitHeading('1'),
                    _getScreenContainer(),
                    _getExitHeading('2'),
                  ],
                ),
                SizedBox(height: deviceSize.height * 0.01),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    'All Eyes This Way Please!',
                    style: MyTheme.currentTheme.textTheme.displaySmall,
                  ),
                )
              ],
            ),
          ),
        );
      } else {
        return Container();
      }
    });
  }

  _getHeading(String heading) {
    return Text(heading.toUpperCase(),
        style: const TextStyle(
            color: Colors.grey, fontWeight: FontWeight.w800, fontSize: 18));
  }

  _getExitHeading(String gate) {
    return Container(
      padding: EdgeInsets.all(deviceSize.width * 0.005),
      height: deviceSize.height * 0.025,
      width: deviceSize.width * 0.12,
      decoration: const BoxDecoration(
        color: Colors.black54,
      ),
      child: Center(
          child: Text(
        "EXIT-$gate",
        style: const TextStyle(color: Colors.white),
      )),
    );
  }

  _getScreenContainer() {
    return Container(
      height: deviceSize.height * 0.02,
      width: deviceSize.width * 1.1,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(deviceSize.width * 0.2),
            topLeft: Radius.circular(deviceSize.width * 0.2),
          ),
          gradient: const LinearGradient(
            colors: [Colors.white, Colors.blueGrey],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0, 1],
          )),
    );
  }

  _printRowNames([int startingIndex = 0,int rowCount = 3,double height = 0.17,double boxheight = 35]) {
    return Container(
      color: Colors.grey,
      width: deviceSize.width * 0.03,
      height: deviceSize.height * 0.17,
      padding: EdgeInsets.only(top: deviceSize.height *0.03),
      child: ListView.builder(
          itemCount: 3,
          itemBuilder: ((context, index) {
            return Container(
              height: 35,
              width: 28,
              child: Center(
                child: Text(
                  props[4][index+startingIndex],
                  style: MyTheme.currentTheme.textTheme.displaySmall,
                ),
              ),
            );
          })),
    );
  }
}
