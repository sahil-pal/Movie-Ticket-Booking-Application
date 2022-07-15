import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../config/constants/app_constants.dart';
import '../model/event.dart';

class EventOperations{

  static EventOperations eventOperations = EventOperations();

  static EventOperations getEventOperationInstance(){
    return eventOperations;
  }

  _EventOperations(){}

  FirebaseFirestore db = FirebaseFirestore.instance;

  Future<List<Event>> read() async{

    QuerySnapshot querySnapshot = await db.collection(Collections.EVENTS).orderBy('ticketPrice',descending: true).get();
    List<QueryDocumentSnapshot> docList = querySnapshot.docs;
    List<Event> eventList = docList.map((QueryDocumentSnapshot doc) => Event.fromJSON(doc)).toList();
    return eventList;
  }
}