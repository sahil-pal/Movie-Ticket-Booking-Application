import 'package:bigboxo_application/config/constants/app_constants.dart';
import 'package:bigboxo_application/modules/booking/cubit/booking_state.dart';
import 'package:bigboxo_application/modules/booking/models/ticket.dart';
import 'package:bigboxo_application/modules/booking/repo/theatre_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../utils/services/conversion.dart';
import '../models/theatre.dart';

class BookingCubit extends Cubit<BookingState>{

  late TheatreOperations theatreOperations;

  BookingCubit({required this.theatreOperations}):super(LoadingState()){
      emit(IntialBookState());
  }

  selectDate(int selectedIndex,String theatreName,String movieName) async{
    try{
       Theatre theatreDetails = await theatreOperations.getTheatreDetails(theatreName,movieName,selectedIndex);
       emit(DateAndSeatNumSelection(numberOfSeats: 1,selectedDateIndex: selectedIndex,timeSelectedIndex: 0,theatreDetails: theatreDetails));
    }
    catch(err){
      emit(LoadingError(err.toString()));
    }
  }

  selectShowTiming(int selectedIndex){
    List<dynamic> props = state.props.toList();
    emit(DateAndSeatNumSelection(numberOfSeats:1,selectedDateIndex: props[1],timeSelectedIndex: selectedIndex,theatreDetails: props[2]));
  }

  selectNumOfSeat(int selectedIndex){
    List<dynamic> props = state.props.toList();
    emit(DateAndSeatNumSelection(numberOfSeats:selectedIndex,selectedDateIndex: props[1],timeSelectedIndex: props[3],theatreDetails: props[2]));
  }

  moveToSeatSelection(){
    List<dynamic> props = state.props.toList();
    DateTime currentDate = DateTime.now().add(Duration(days: props[1]));
    Map<String,String> ticketPrices = {};
    String selectedTime = props[4][props[3]];
    Set<int> royalSold = {};
    Set<int> executiveSold = {};
    props[2].booked[selectedTime].forEach((key, value) => {
        if(key == SeatTypes.TYPE1){
          value.forEach((e)=>royalSold.add(e))
        }
        else{
          value.forEach((e)=>executiveSold.add(e))
        }
      },
    );
    ticketPrices.putIfAbsent(SeatTypes.TYPE1, () => (currentDate.weekday>5)?props[2].ticketType['weekend'][1]:props[2].ticketType['weekday'][1]);
    ticketPrices.putIfAbsent(SeatTypes.TYPE2, () => (currentDate.weekday>5)?props[2].ticketType['weekend'][0]:props[2].ticketType['weekday'][0]);
    Ticket ticket = Ticket(numOfSeats: props[0], ticketPrice: ticketPrices, date: currentDate.toString().substring(0,11),time: props[4][props[3]],movie:props[2].currMovieSelected,theatreName:props[2].name,seatNumbers: []);
    emit(SeatSelection(ticket: ticket,seatSelected: 0,royaleBooking:{},executiveBooking:{},royaleBooked: royalSold,executiveBooked: executiveSold));
  }

  royaleSeatSelected(int index){
    List<dynamic> props = state.props.toList();
    Set<int> selectedIndex = props[2];
    if(selectedIndex.contains(index)){
      selectedIndex.remove(index);
      emit(SeatSelection(ticket: props[0], seatSelected: (props[1]-1),royaleBooking:selectedIndex,executiveBooking:props[3],royaleBooked: props[5],executiveBooked: props[6]));
    }
    else{
      selectedIndex.add(index);
      emit(SeatSelection(ticket: props[0], seatSelected: (props[1]+1),royaleBooking:selectedIndex,executiveBooking:props[3],royaleBooked: props[5],executiveBooked: props[6]));
    }
  }

  royaleSeatRemove(int index){
    List<dynamic> props = state.props.toList();
    Set<int> selectedIndex = props[2];
    if(selectedIndex.contains(index)){
      selectedIndex.remove(index);
      emit(SeatSelection(ticket: props[0], seatSelected: (props[1]-1),royaleBooking:selectedIndex,executiveBooking:props[3],royaleBooked: props[5],executiveBooked: props[6]));
    }
    else{
      emit(SeatSelection(ticket: props[0], seatSelected: props[1],royaleBooking:selectedIndex,executiveBooking:props[3],royaleBooked: props[5],executiveBooked: props[6]));
    }
  }

  executiveSeatSelected(int index){
    List<dynamic> props = state.props.toList();
    Set<int> selectedIndex = props[3];
    if(selectedIndex.contains(index)){
      selectedIndex.remove(index);
      emit(SeatSelection(ticket: props[0], seatSelected: (props[1]-1),royaleBooking:props[2],executiveBooking:selectedIndex,royaleBooked: props[5],executiveBooked: props[6]));
    }
    else{
      selectedIndex.add(index);
      emit(SeatSelection(ticket: props[0], seatSelected: (props[1]+1),royaleBooking:props[2],executiveBooking:selectedIndex,royaleBooked: props[5],executiveBooked: props[6]));
    }
  }

  executiveSeatRemove(int index){
    List<dynamic> props = state.props.toList();
    Set<int> selectedIndex = props[3];
    if(selectedIndex.contains(index)){
      selectedIndex.remove(index);
      emit(SeatSelection(ticket: props[0], seatSelected: (props[1]-1),royaleBooking:props[2],executiveBooking:selectedIndex,royaleBooked: props[5],executiveBooked: props[6]));
    }
    else{
      emit(SeatSelection(ticket: props[0], seatSelected: props[1],royaleBooking:props[2],executiveBooking:selectedIndex,royaleBooked: props[5],executiveBooked: props[6]));
    }
  }

  moveToPayments(BuildContext context){
    List<dynamic> props = state.props.toList();
    List<String> ticketNumbers = Conversion.convertIndexToSeatNumbers(props[2],props[3],props[4]);
    Ticket ticket = Ticket(numOfSeats: props[0].numOfSeats, ticketPrice: props[0].ticketPrice, date: props[0].date, time: props[0].time,movie:props[0].movie,theatreName:props[0].theatreName,seatNumbers: ticketNumbers);
    Navigator.of(context).pushNamed(RouteConstants.PAYMENTS,arguments:{'Ticket':ticket} );
    Future.delayed(const Duration(seconds: 1),(){
      emit(IntialBookState());
    });
  }

  moveToTrump(BuildContext context){
    List<dynamic> props = state.props.toList();
    List<String> ticketNumbers = Conversion.convertIndexToSeatNumbers(props[2],props[3],props[4]);
    Ticket ticket = Ticket(numOfSeats: props[0].numOfSeats, ticketPrice: props[0].ticketPrice, date: props[0].date, time: props[0].time,movie:props[0].movie,theatreName:props[0].theatreName,seatNumbers: ticketNumbers);
    Navigator.of(context).pushNamed(RouteConstants.TRUMP,arguments:{'Ticket':ticket} );
    Future.delayed(const Duration(seconds: 1),(){
      emit(IntialBookState());
    });
  }

}