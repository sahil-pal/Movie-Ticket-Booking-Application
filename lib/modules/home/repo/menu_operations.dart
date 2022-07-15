import '../model/menu.dart';

class MenuOperations{

  static MenuOperations menuOperations = MenuOperations();

  static MenuOperations getMenuOperationInstance(){
    return menuOperations;
  }
  
  _MenuOperations(){}

  List<Menu> getMenuList(){
    return [
      Menu(name: "Movies", asset: "assets/icons/film.svg"),
      Menu(name: "Events", asset: "assets/icons/spotlights.svg"),
      Menu(name: "Plays", asset: "assets/icons/theater_masks.svg"),
      Menu(name: "Sports", asset: "assets/icons/running.svg"),
      Menu(name: "Activity", asset: "assets/icons/flag.svg"),
      Menu(name: "Monum", asset: "assets/icons/pyramid.svg"),
    ];
  }
}