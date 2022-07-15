
class theatre_client{

  static Map<String,List<String>> _theatresList = {
    'Gurugram' : ['PVR: Ambience Mall','Carnival: Raheja Mall','Inox: Gurgaon Dreamz','Cinepolis: Airia Mall'],
    'Noida' : ['Carnival: TGIP','Cinepolis: Bharat Mall','PVR : logix'],
    'Delhi' : ['Inox : Janak Palace','Cinepolis: DLF Avenue Saket','Cinepolis: Cross River Mall']
  };

  static List<String> getTheatreByCity(String cityName){
    return _theatresList[cityName]!;
  }
}