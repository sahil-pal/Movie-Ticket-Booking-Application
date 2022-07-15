import 'package:bigboxo_application/modules/home/cubit/states/search_state.dart';
import 'package:bigboxo_application/modules/home/repo/movie_operations.dart';
import 'package:bigboxo_application/modules/home/services/theatre_client.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../model/movie.dart';

class SearchCubit extends Cubit<SearchState>{

  late MovieOperations movieOperations;

  SearchCubit({required this.movieOperations}) : super(Loading()) {
    loadIntialState();
  }

  void loadIntialState(){
    emit(InitialState());
  }

  void selectTheatre(String cityName){
    List<String> theatreList = theatre_client.getTheatreByCity(cityName);
    emit(SelectTheatre(city: cityName,theatres: theatreList));
  }

  void getFilteredResults(String theatreName) async{
    emit(Loading());
    try{
      List<Movie> moviesByTheatre = await movieOperations.getMoviesByTheatre(theatreName);
      emit(ShowResults(moviesByTheatre,theatreName));
    }catch(err){
      emit(LoadingError(err.toString()));
    }
  }

  void getResultsBySearch(String keyword) async{
    emit(Loading());
    try{
      List<Movie> moviesBySearch = await movieOperations.getMoviesBykeyword(keyword);
      emit(ShowResults(moviesBySearch));
    }catch(err){
      emit(LoadingError(err.toString()));
    }
  }
  
}