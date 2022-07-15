class Conversion{

  static Map<String,int> rowNames = 
  {'A':1,'B':2,'C':3,'D':4,'E':5,'F':6,'G':7,'H':8,'I':9,'J':10,'K':11};

  static List<String> convertIndexToSeatNumbers(Set<int> royaleBooking,Set<int> executiveBooking,List<String> rowNames){
    List<String> ticketNumbers = [];
    royaleBooking.forEach((element) {
        String row = (rowNames[element~/19])+":"+(element%19+1).toString();
        ticketNumbers.add(row);
    });
    executiveBooking.forEach((element) {
        String row = (rowNames[(element~/19)+3])+":"+(element%19+1).toString();
        ticketNumbers.add(row);
    });
    return ticketNumbers;
  }

  static List<dynamic> convertSeatNumberToRoyaleIndex(List<dynamic> bookedTickets,List<String> ticketNumbers){
    ticketNumbers.forEach(
      (element) { 
        if(element.startsWith('A') || element.startsWith('B') || element.startsWith('C')){
          int rowCount = rowNames[element.substring(0,1)]!;
          bookedTickets.add(int.parse(element.substring(2))+((rowCount-1)*(19))-1);
        }
      }
    );
    return bookedTickets;
  }

  static List<dynamic> convertSeatNumberToExecutiveIndex(List<dynamic> bookedTickets,List<String> ticketNumbers){
    ticketNumbers.forEach(
      (element) { 
        if(!element.startsWith('A') && !element.startsWith('B') && !element.startsWith('C')){
          int rowCount = rowNames[element.substring(0,1)]!;
          bookedTickets.add(int.parse(element.substring(2))+((rowCount-4)*19)-1);
        }
      }
    );
    return bookedTickets;
  }
}