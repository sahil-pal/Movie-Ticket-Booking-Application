import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../config/constants/app_constants.dart';
import '../model/play.dart';

class PlayOperations{

  static PlayOperations playOperations = PlayOperations();

  static PlayOperations getPlayOperationInstance(){
    return playOperations;
  }

  _PlayOperations(){}

  FirebaseFirestore db = FirebaseFirestore.instance;

  Future<List<Play>> read() async{

    QuerySnapshot querySnapshot = await db.collection(Collections.PLAYS).orderBy('ticketPrice').get();
    List<QueryDocumentSnapshot> docList = querySnapshot.docs;
    List<Play> playList = docList.map((QueryDocumentSnapshot doc) => Play.fromJSON(doc)).toList();
    return playList;
  }
}