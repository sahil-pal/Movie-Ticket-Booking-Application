import 'package:cloud_firestore/cloud_firestore.dart';

class Theatre{

  late int day;
  late Map<String,dynamic> ticketType;
  late Map<String,dynamic> booked;
  late String name;
  late String currMovieSelected;

  Theatre({
    required this.ticketType,
    required this.name,
    required this.booked,
    required this.currMovieSelected,
    required this.day
  });

  Theatre.fromDocument(QueryDocumentSnapshot doc,String theatreName){
    ticketType = doc['ticketType'];
    currMovieSelected = doc['name'];
    booked = doc['booked'];
    name = theatreName;
    day = doc['day'];
  }

   Map<String,dynamic> toJSON(){
    return {
      'day' : day,
      'booked' : booked,
      'ticketType' : ticketType,
      'name' : currMovieSelected
    };
  }

  @override
  String toString() {
    return "name : $name";
  }

}