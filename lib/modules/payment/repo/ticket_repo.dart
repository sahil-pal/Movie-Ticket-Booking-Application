import 'package:bigboxo_application/config/constants/app_constants.dart';
import 'package:bigboxo_application/modules/booking/models/theatre.dart';
import 'package:bigboxo_application/utils/services/conversion.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../booking/models/ticket.dart';

class TicketOperations{

  static TicketOperations ticketOperations = TicketOperations();

  _TicketOperations(){

  }

  static TicketOperations getTicketOprInstance(){
    return ticketOperations;
  }

  FirebaseFirestore db = FirebaseFirestore.instance;

  void updateBookedSeats(Ticket ticket) async{

    int ticketDate = int.parse(ticket.date.substring(8,10));
    int index = ticketDate - int.parse(DateTime.now().toString().substring(8,10));
    QuerySnapshot snapshot = await db.collection(Collections.THEATRES+"/${ticket.theatreName}/movies").where("name",isEqualTo: ticket.movie).orderBy("day").get();
    DocumentReference reference = snapshot.docs[index].reference;
    Theatre theatre = Theatre.fromDocument(snapshot.docs[index], ticket.theatreName);
    Map<String,dynamic> newData = {
        SeatTypes.TYPE1 : Conversion.convertSeatNumberToRoyaleIndex(theatre.booked[ticket.time][SeatTypes.TYPE1],ticket.seatNumbers),
        SeatTypes.TYPE2 : Conversion.convertSeatNumberToExecutiveIndex(theatre.booked[ticket.time][SeatTypes.TYPE2],ticket.seatNumbers),
    };
    Map<String,dynamic> booked = {};
    theatre.booked.forEach((key, value) {
        if(!(key == ticket.time)){
          booked.putIfAbsent(key, () => value);
        }
        else{
          booked.putIfAbsent(key, () => newData);
        }
    });
    reference.update({'booked':booked});
  }
}