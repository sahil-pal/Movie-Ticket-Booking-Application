import 'package:bigboxo_application/config/constants/app_constants.dart';
import 'package:bigboxo_application/config/themes/mytheme.dart';
import 'package:bigboxo_application/modules/home/cubit/states/search_state.dart';
import 'package:bigboxo_application/modules/home/widgets/dropdown.dart';
import 'package:bigboxo_application/modules/home/widgets/search_items_skeleton.dart';
import 'package:bigboxo_application/utils/helpers/string_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/search_cubit.dart';
import '../model/movie.dart';
import '../widgets/search_box.dart';

class SearchScreen extends StatelessWidget {
  
  late SearchCubit searchCubit;
  late Size deviceSize;
  late BuildContext context;
  late String theatreName;
  late List<dynamic> prop;
  
  @override
  Widget build(BuildContext context) {
    this.context = context;
    deviceSize = MediaQuery.of(context).size;
    searchCubit = BlocProvider.of<SearchCubit>(context);
    
    return BlocBuilder<SearchCubit, SearchState>(builder: (context, state) {
      if (state is InitialState) {
        prop = state.props.toList();
        return _printInitialView(prop[0]);
      }
      else if(state is SelectTheatre){
        prop = state.props.toList();
        return _printSelectTheatre(prop[1],prop[0]);
      }
      else if(state is ShowResults){
        prop = state.props.toList();
        return _printResults(prop[0]);
      }
      else if(state is Loading){
        return Container(
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.all(10),
          child: SearchItemSkeleton()
        );
      }
      else {
        return Center(
          child: Container(
            child: _printClearButton()
          ),
        );
      }

    });
  }

  // initial view
  _printInitialView(List<String> data) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      child: Column(
        //crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SearchBox(),
          const SizedBox(height: 15),
          const Divider(color: MyTheme.splash),
          MyDropDown(hint: HintConstants.CITY_HINT, data: data,changeFn: getTheatreList),
          const SizedBox(height: 5),
          MyDropDown(hint: HintConstants.THEATRE_HINT, data: const [''],changeFn: null,ignored: true,),
        ],
      ),
    );
  }

  // select theatre view
  _printSelectTheatre(List<String> data,String cityName) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: _printClearButton()
          ),
          MyDropDown(hint: cityName, data: const [],ignored: true,),
          const SizedBox(height: 5),
          MyDropDown(hint: HintConstants.THEATRE_HINT, data: data,changeFn: getFilteredMovies),
        ],
      ),
    );
  }

  // print filtered results
  _printResults(List<Movie> movies){
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          _printResultInfo(searchCount : movies.length),
          const Divider(color: MyTheme.splash),
          Container(
            height: deviceSize.height*0.69,
            child: _printMovies(movies)
          ),
        ],
      )
    );
  }

  // print Movies
  _printMovies(List<Movie> movies){
    return ListView.builder(
      itemCount: movies.length,
      itemBuilder: (BuildContext b, int index) {
          return Card(
            color: Colors.blueGrey.withOpacity(0.8),
            elevation: 3,
            child: Container(
              padding: const EdgeInsets.all(5),
              height: deviceSize.height*0.16,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: deviceSize.height*0.24,
                      maxHeight: deviceSize.height*0.24,
                      minWidth: deviceSize.width*0.18,
                      maxWidth: deviceSize.width*0.2
                    ),
                    child: Image.network(movies[index].imageurl,fit: BoxFit.fill,),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: deviceSize.height*0.02),
                      Container(
                        width: deviceSize.width*0.33,
                        child: Text(
                            movies[index].title,
                              style: const  TextStyle(fontSize: 15,fontWeight: FontWeight.bold)
                        ),
                      ),
                      Text(
                        StringHelper.convertToCategoryFormat(movies[index].genres)
                      ),
                      Text('Rating ★ : '+movies[index].rating.toString())
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: (){
                          Navigator.pushNamed(context, RouteConstants.MOVIE_DETAILS,arguments: {'imdbid' : movies[index].imdbid,'theatreName' : (prop[1] != '')?prop[1]:movies[index].theatreName});
                        }, 
                        child: const Text('View Details'),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.green
                        ),
                      ),
                      ElevatedButton(
                        onPressed: (){
                           Navigator.pushNamed(context, RouteConstants.BOOKING,arguments: {'movieName' : movies[index].title,'theatreName' : (prop[1] != '')?prop[1]:movies[index].theatreName});
                        }, child: const Text('Book Tickets'),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.red
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )
        );
      },
    );
  }

  // clear the state
  _printClearButton(){
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: MyTheme.splash
      ),
      onPressed: (){ searchCubit.loadIntialState();}, 
      child: Text('Clear'.toUpperCase(),style: MyTheme.currentTheme.textTheme.bodyMedium)
    );
  }

  // print the Result count
  _printResultInfo({required int searchCount}){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(
          '$searchCount Results found',
          style: MyTheme.currentTheme.textTheme.displaySmall,
        ),
        _printClearButton()
      ],
    );
  }

  // function to get theatre list and update state 
  getTheatreList(String cityName){
    searchCubit.selectTheatre(cityName);
  }

  // function to get filtered results and update state
  getFilteredMovies(String theatreName){
    searchCubit.getFilteredResults(theatreName);
  }
 
}
