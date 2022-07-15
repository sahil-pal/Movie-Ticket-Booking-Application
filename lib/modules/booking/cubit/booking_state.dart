import 'package:bigboxo_application/modules/booking/models/theatre.dart';
import 'package:bigboxo_application/modules/booking/models/ticket.dart';
import 'package:equatable/equatable.dart';

class BookingState extends Equatable{
  @override
  List<Object?> get props => [];
}

class LoadingState extends BookingState{
  @override
  List<Object?> get props => [];
}

class IntialBookState extends BookingState{

  final int numberOfSeats = 1;
  final int selectedDateIndex = -1;
  IntialBookState();
  @override
  List<Object?> get props => [numberOfSeats,selectedDateIndex];

}

class DateAndSeatNumSelection extends BookingState{

  final int numberOfSeats;
  final int selectedDateIndex;
  final int timeSelectedIndex;
  final Theatre theatreDetails;
  final List<String> timings = [
    '10:00 AM','01:00 PM','04:00 PM','07:00 PM'
  ];

  DateAndSeatNumSelection({required this.numberOfSeats,required this.selectedDateIndex,required this.timeSelectedIndex,required this.theatreDetails});
  @override
  List<Object?> get props => [numberOfSeats,selectedDateIndex,theatreDetails,timeSelectedIndex,timings];

}

class SeatSelection extends BookingState{

  late Ticket ticket;
  late int seatSelected;
  Set<int> royaleBooking = {};
  Set<int> executiveBooking = {};
  Set<int> royaleBooked = {};
  Set<int> executiveBooked = {};
  List<String> rowNames = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I','J','K'];

  SeatSelection({required this.ticket,required this.seatSelected,required this.royaleBooking,required this.executiveBooking,required this.royaleBooked,required this.executiveBooked});

  @override
  List<Object?> get props => [ticket,seatSelected,royaleBooking,executiveBooking,rowNames,royaleBooked,executiveBooked];
}

class LoadingError extends BookingState{

  final String err;

  LoadingError(this.err);

  @override
  List<Object?> get props => [err];
}