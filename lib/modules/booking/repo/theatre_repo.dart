import 'package:bigboxo_application/config/constants/app_constants.dart';
import 'package:bigboxo_application/modules/booking/models/theatre.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../home/model/movie.dart';

class TheatreOperations{

  static TheatreOperations theatreOperations = TheatreOperations();

   static TheatreOperations getTheatreOperationsInstance(){
    return theatreOperations;
  }
  
  _TheaterOperations(){}

  FirebaseFirestore db = FirebaseFirestore.instance;

  Future<Theatre> getTheatreDetails(String theatreName,String movieName,int selectedIndex) async{
    
    DateTime currentDate = DateTime.now().add(Duration(days: selectedIndex));
    QuerySnapshot querySnapshot = await db.collection(Collections.THEATRES+"/$theatreName/movies").where("name",isEqualTo: movieName).where("day",isEqualTo: currentDate.weekday).get();
    List<QueryDocumentSnapshot> docList = querySnapshot.docs;
    List<Theatre> theatreList = docList.map((e) => Theatre.fromDocument(e,theatreName)).toList();
    return theatreList[0];
  }

  // addSample()async {
  //     QuerySnapshot querySnapshot = await db.collection(Collections.MOVIES).get();
  //     List<QueryDocumentSnapshot> docList = querySnapshot.docs;
  //     List<Movie> movieList = docList.map((QueryDocumentSnapshot doc) => Movie.fromDocument(doc)).toList();
  //     Map<String,List<String>> ticketType = {
  //       'weekday' : ['80','150'],
  //       'weekend' : ['120','200']
  //     };
  //     Map<String,dynamic> booked = {
  //       '10:00 AM' : {
  //         'Royale' : [3],
  //         'Executive':[3]
  //       },
  //       '01:00 PM' : {
  //         'Royale' : [2],
  //         'Executive':[2]
  //       },
  //       '04:00 PM' : {
  //         'Royale' : [4],
  //         'Executive':[4]
  //       },
  //       '07:00 PM' : {
  //         'Royale' : [5],
  //         'Executive':[5]
  //       },
  //     };
  //     List<String> theatreList = [
  //       'Carnival: TGIP',
  //       //'PVR: Ambience Mall',
  //       //'Carnival: Raheja Mall',
  //       //'Cinepolis: Airia Mall',
  //       'Cinepolis: Bharat Mall',
  //       //'Inox: Gurgaon Dreamz',
  //       'PVR : logix',
  //       'Inox : Janak Palace',
  //       'Cinepolis: DLF Avenue Saket',
  //       'Cinepolis: Cross River Mall'
  //     ];

      
  //     for(int i = 1; i <= 7; i++){
  //       Theatre theatre = Theatre(ticketType: ticketType, name: ' ', booked: booked, currMovieSelected: 'K.G.F : Chapter 2', day: i);
  //       theatreList.forEach((e) async{
  //           await db.collection(Collections.THEATRES+"/$e/movies").add(theatre.toJSON());
  //       });
  //     }
      
  // }

  
}