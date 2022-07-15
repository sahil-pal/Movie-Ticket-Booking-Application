import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

class Movie {
  late String imdbid;
  late String title;
  late double rating;
  late int released;
  late String imageurl;
  late List<String> genres;
  late String theatreName;

  Movie({
    required this.imdbid,
    required this.title,
    required this.rating,
    required this.imageurl,
    required this.released,
    required this.genres,
    this.theatreName = ''
  });

  Map<String, dynamic> toMap() {
    return {
      'imdbid' : imdbid,
      'title': title,
      'rating' : rating,
      'imageurl': imageurl,
      'released' : released,
      'genres' : genres
    };
  }

  Movie.fromJSON(Map<String,dynamic> doc) {
    imdbid = doc['imdbid'];
    title = doc['title'];
    rating = (doc['imdbrating'] != null ) ? (double.parse(doc['imdbrating'].toString())) : 6.0;
    imageurl = (doc['imageurl'].length == 0) ? 'empty' : doc['imageurl'][0].toString();
    released = int.parse(doc['released'].toString());
    genres = List<String>.generate(doc['genre'].length,((index) => doc['genre'][index].toString()));
  }

  Movie.fromDocument(QueryDocumentSnapshot doc) {
    title = doc['title'];
    genres =  List<String>.generate(doc['genres'].length,((index) => doc['genres'][index].toString()));
    imdbid = doc['imdbid'];
    released = int.parse(doc['released'].toString());
    rating = doc['imdbrating'];
    imageurl = doc['imageurl'];
    theatreName = doc['theatres'][0].toString();
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'Movie (title: $title)';
  }

}