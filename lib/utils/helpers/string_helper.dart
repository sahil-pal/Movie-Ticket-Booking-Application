
class StringHelper{
  static String convertToCategoryFormat(List<String> list){
    StringBuffer sb = StringBuffer();
    for(int i = 0; i < list.length; i++){
      if(i == list.length-1){
        sb.write(list[i]);
      }
      else{
        sb.write(list[i]+" | ");
      }
    }
    return sb.toString();
  }
}