import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

class Movie {

  final String demo = "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRK8M-_HWvKjCLolLLMutVWYm8hFA5XRIGeNRUHlIg4RTa-0XfkyUY1BAI2kCmXVTFttYg&usqp=CAU";

  late String title;
  late String trailer;
  late String imdb_rating;
  late String original_lang;
  late String description;
  late String certification;
  late String released_date;
  List<String> actors = ['Actor1','Actor2','Actor3','Actor4','Actor5'];
  List<String> crews = ['crew1','crew2','crew3','crew4','crew5'];

  Movie({
    required String title,
    required String trailer,
    required String imdb_rating,
    required String original_lang,
    required String description,
    required String certification,
    required String released_date,
  });

  Map<String, dynamic> toMap() {
    return {
      'title' : title,
      'trailer' : trailer,
      'rating' : imdb_rating,
      'language' : original_lang,
      'description' : description,
      'certification' : certification,
      'date' : released_date,
      'actors_list' : actors,
      'crew_members' : crews
    };
  }

  Movie.fromJSON(Map<String,dynamic> doc) {
    title = doc['title'];
    trailer = doc['trailer'] ?? demo;
    imdb_rating = doc['ratings'][0]['value'].toString();
    original_lang = doc['language'];
    description = doc['description'];
    certification = doc['certification'];
    released_date = doc['released'];
  }


  String toJson() => json.encode(toMap());

  static String convertToYoutubeID(String URL){
   
    int index  = URL.indexOf('v=',0);
    if(index == -1){
      return URL;
    }
    else{
      StringBuffer sb = StringBuffer();
      for(int i = index+2; i < URL.length; i++){
        sb.write(URL[i]);
      }
      return sb.toString();
    }
  }

  @override
  String toString() {
    return 'Movie (title: $title)';
  }

}