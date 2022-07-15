import 'package:bigboxo_application/config/constants/app_constants.dart';

class Ticket{

  late String movie;
  late String theatreName;
  late int numOfSeats;
  List<String> seatNumbers;
  late Map<String,String> ticketPrice;
  late String date;
  late String time;

  Ticket({
    required this.numOfSeats,
    required this.ticketPrice,
    required this.date,
    required this.time,
    required this.movie,
    required this.theatreName,
    required this.seatNumbers,
  });

  static fromTrumpMap({required Map objMap}){
    objMap['seats'] = objMap['seats'].substring(1,objMap['seats'].length-1);
    List<String> tempSeatNumber = objMap['seats'].split(", ");
    return Ticket(
      numOfSeats: objMap['seats'].length,
      ticketPrice: {
        SeatTypes.TYPE1 : objMap['deal'].toString(),
        SeatTypes.TYPE2 : objMap['deal'].toString()
      
      },
      date: objMap['date'],
      time: objMap['time'],
      movie: objMap['movie'], 
      theatreName: objMap['theatre'], 
      seatNumbers: tempSeatNumber
    );
  }


  @override
  String toString() {
    return "$movie $theatreName $numOfSeats $seatNumbers $ticketPrice $date $time";
  }
  
}