import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../config/constants/app_constants.dart';
import '../model/movie.dart';

class MovieOperations{

  static MovieOperations movieOperations = MovieOperations();

  static MovieOperations getMovieOperationInstance(){
    return movieOperations;
  }

  _MovieOperations(){}

  FirebaseFirestore db = FirebaseFirestore.instance;

  Future<List<Movie>> getMoviesByTheatre(String theatreName) async{
    QuerySnapshot querySnapshot = await db.collection(Collections.MOVIES).where("theatres",arrayContains: theatreName).get();
    List<QueryDocumentSnapshot> docList = querySnapshot.docs;
    List<Movie> movieList = docList.map((QueryDocumentSnapshot doc) => Movie.fromDocument(doc)).toList();
    return movieList;
  }

  Future<List<Movie>> getMoviesBykeyword(String keyword) async{
    QuerySnapshot querySnapshot = await db.collection(Collections.MOVIES).get();
    List<QueryDocumentSnapshot> docList = querySnapshot.docs;
    List<Movie> allMovieList = docList.map((QueryDocumentSnapshot doc) => Movie.fromDocument(doc)).toList();
    List<Movie> movieList = [];
    allMovieList.forEach(
      (movie) {
        print('Inside movie list');
        if(movie.title.toLowerCase().contains(keyword.toLowerCase())){
          movieList.add(movie);
        }
       }
    );
    return movieList;
  }
}