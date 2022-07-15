import 'dart:convert';

class Show {
  late String imdbid;
  late String title;
  late double rating;
  late int released;
  late String imageurl;
  late List<String> genres;

  Show({
    required this.imdbid,
    required this.title,
    required this.rating,
    required this.imageurl,
    required this.released,
    required this.genres,
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

  Show.fromJSON(Map<String,dynamic> doc) {
    print('Inside');
    imdbid = doc['imdbid'];
    title = doc['title'];
    rating = (doc['imdbrating'] != null ) ? (double.parse(doc['imdbrating'].toString())) : 6.0;
    imageurl = (doc['imageurl'].length == 0 || doc['imageurl'] == null) ? 'empty' : doc['imageurl'][0].toString();
    released = int.parse(doc['released'].toString());
    genres = List<String>.generate(doc['genre'].length,((index) => doc['genre'][index].toString()));
    print('Inside new');
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'Movie (title: $title, imageURL: $imageurl)';
  }

}