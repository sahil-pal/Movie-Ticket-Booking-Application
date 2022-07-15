import 'package:cloud_firestore/cloud_firestore.dart';

class Play {
  late String name;
  late List<String> artists;
  late List<String> category;
  late String bannerURL;
  late double duration;
  late int ticketprice;
  late List<String> languages;
  late String date;

  Play({
    required this.name,
    required this.artists,
    required this.bannerURL,
    required this.date,
    required this.duration,
    required this.category,
    required this.languages,
    required this.ticketprice,
  });

  Play.fromJSON(QueryDocumentSnapshot doc) {
    name = doc['name'];
    artists =  List<String>.generate(doc['artists'].length,((index) => doc['artists'][index].toString()));
    bannerURL = doc['bannerURL'];
    date = doc['date'];
    duration = double.parse(doc['duration'].toString());
    category =  List<String>.generate(doc['category'].length,((index) => doc['category'][index].toString()));
    languages =  List<String>.generate(doc['languages'].length,((index) => doc['languages'][index].toString()));
    ticketprice = doc['ticketPrice'];
  }

  Play.fromMap(dynamic doc) {
    name = doc['name'];
    artists = doc['artists'];
    bannerURL = doc['bannerURL'];
    duration = doc['duration'];
    languages = doc['languages'];
    date = doc['date'];
    category = doc['category'];
    ticketprice = doc['ticketprice'];
  }

  Map<String, dynamic> toJSON() {
    return {
      'name': name,
      'artists' : artists,
      'bannerURL' : bannerURL,
      'duration' : duration,
      'date' : date,
      'languages' : languages,
      'category' : category,
      'ticketPrice' : ticketprice
    };
  }

  @override
  String toString() {
    return 'Play Model(title: $name, artists: $artists, bannerUrl: $bannerURL, date: $date)';
  }
}