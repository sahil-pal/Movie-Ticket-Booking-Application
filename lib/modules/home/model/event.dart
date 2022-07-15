import 'package:cloud_firestore/cloud_firestore.dart';

class Event {
  late String name;
  late List<String> artists;
  late String bannerURL;
  late String day;
  late int ticketprice;
  late String category;
  late String date;

  Event({
    required this.name,
    required this.artists,
    required this.bannerURL,
    required this.date,
    required this.day,
    required this.category,
    required this.ticketprice,
  });

  Event.fromJSON(QueryDocumentSnapshot doc) {
    name = doc['name'];
    artists =  List<String>.generate(doc['artists'].length,((index) => doc['artists'][index].toString()));
    bannerURL = doc['bannerURL'];
    day = doc['day'];
    date = doc['date'];
    category = doc['category'];
    ticketprice = doc['ticketPrice'];
  }

  Event.fromMap(dynamic doc) {
    name = doc['name'];
    artists = doc['artists'];
    bannerURL = doc['bannerURL'];
    day = doc['day'];
    date = doc['date'];
    category = doc['category'];
    ticketprice = doc['ticketprice'];
  }

  Map<String, dynamic> toJSON() {
    return {
      'name': name,
      'artists' : artists,
      'bannerURL' : bannerURL,
      'day' : day,
      'date' : date,
      'category' : category,
      'ticketPrice' : ticketprice
    };
  }

  @override
  String toString() {
    return 'EventModel(title: $name, artists: $artists, bannerUrl: $bannerURL, date: $date)';
  }

}