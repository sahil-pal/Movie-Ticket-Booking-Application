import 'package:bigboxo_application/modules/home/model/movie.dart';
import 'package:equatable/equatable.dart';

abstract class SearchState extends Equatable{}

class Loading extends SearchState{
  @override
  List<Object?> get props => [];
}

class InitialState extends SearchState{

  final List<String> cities = ['Delhi','Gurugram','Noida'];

  @override
  List<Object> get props => [cities];
}

class SelectTheatre extends SearchState{

  final String city;
  final List<String> theatres;

  SelectTheatre({required this.city,required this.theatres});

  @override
  List<Object> get props => [city,theatres];

}

class ShowResults extends SearchState{

  final List<Movie> searchedResults;
  String? theatreName;

  ShowResults(this.searchedResults,[this.theatreName]);

  @override
  List<Object> get props => [searchedResults,theatreName??''];

}

class LoadingError extends SearchState{

  final String error;

  LoadingError(this.error);

  @override
  List<Object> get props => [error];
}