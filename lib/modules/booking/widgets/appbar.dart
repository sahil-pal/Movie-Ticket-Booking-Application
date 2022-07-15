import 'package:bigboxo_application/modules/booking/cubit/booking_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../config/themes/mytheme.dart';
import '../cubit/booking_cubit.dart';

class BookingAppBar extends StatelessWidget {
  late String title;
  late String theatreName;

  BookingAppBar({required this.title, required this.theatreName});

  @override
  Widget build(BuildContext context) {
    BookingCubit bookingCubit = BlocProvider.of<BookingCubit>(context);
    return BlocBuilder<BookingCubit, BookingState>(builder: (context, state) {
      if (state is SeatSelection ||
          state is IntialBookState ||
          state is DateAndSeatNumSelection) {
        return AppBar(
            backgroundColor: MyTheme.splash,
            elevation: 0,
            leading: IconButton(
                onPressed: () {
                  (state is SeatSelection)
                  ? bookingCubit.selectDate(0, theatreName,title)
                  : Navigator.pop(context);
                },
                icon: Container(
                    decoration: BoxDecoration(
                      color: Colors.black38,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.all(7),
                    child: const Icon(
                      Icons.arrow_back_ios_new,
                      color: Colors.white,
                    ))),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(this.title,
                    style: MyTheme.currentTheme.textTheme.displayLarge),
                Text(
                  this.theatreName,
                  style: MyTheme.currentTheme.textTheme.bodySmall,
                )
              ],
            ));
      } else {
        return Container();
      }
    });
  }
}
