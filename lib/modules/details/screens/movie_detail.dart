import 'dart:convert';

import 'package:bigboxo_application/config/constants/asset_path.dart';
import 'package:bigboxo_application/config/themes/mytheme.dart';
import 'package:bigboxo_application/modules/details/widgets/detail_skeleton.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../../../config/constants/app_constants.dart';
import '../models/movie.dart';
import '../services/movie_client.dart';

class MovieDetailScreen extends StatelessWidget {
  
  late Size deviceSize;
  late BuildContext context;
  late Movie movie;
  late Map arguments;

  @override
  Widget build(BuildContext context) {
    this.context = context;
    deviceSize = MediaQuery.of(context).size;
    arguments = ModalRoute.of(context)!.settings.arguments as Map;
    MoviesClient moviesClient = MoviesClient.getMovieClientInstance();

    return Container(
        height: deviceSize.height * 0.34,
        child: FutureBuilder(
            future: moviesClient.getMovieDetail(imdbID: arguments['imdbid']), // Firebase read operation , which gives future
            builder:
                (BuildContext ctx, AsyncSnapshot<Response<dynamic>> snapshot) {
              ConnectionState state = snapshot.connectionState;

              // loading
              if (state == ConnectionState.waiting) {
                return Scaffold(
                  body: DetailScreenSkeleton(),
                );
              }
              // error
              else if (snapshot.hasError) {
                return SafeArea(
                      child: Scaffold(
                      body: Center(
                      child: Image.asset(
                        'assets/images/crash.gif',
                         width: deviceSize.width,
                         height: deviceSize.height * 0.34,
                      ),
                    ),
                  ),
                );
              }
              // loaded
              else {
                return _printMovieDetail(snapshot: snapshot);
              }
            }
          )
        );
   
  }

  _printMovieDetail({required AsyncSnapshot snapshot}){

    // logic for retrieval
    Map<String, dynamic> json = jsonDecode(snapshot.data.toString());
    movie = Movie.fromJSON(json);
    
    return Scaffold(
      floatingActionButton: _getFloatingBookTicketsButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      appBar: AppBar(
        backgroundColor: MyTheme.splash,
        elevation: 0,
        leading: IconButton(onPressed: ()=>{
            Navigator.pop(context)
          }, icon: Container(
            decoration: BoxDecoration(
              color: Colors.black38,
              borderRadius: BorderRadius.circular(15),
            ),
            padding: const EdgeInsets.all(7),
            child: const Icon(Icons.arrow_back_ios_new,color: Colors.white,)
          )
        ),
        title: Text(movie.title,style: MyTheme.currentTheme.textTheme.displayMedium),
      ),
      body: Container(
        //margin: const EdgeInsets.only(left: 15,right: 15),
        width: deviceSize.width,
        child: SingleChildScrollView(
            child : Column(
            children: [
              _printYoutubePlayer(),
              const SizedBox(height: 10),
              _printRating(),
              const SizedBox(height: 10),
              _printFramesAndLanguages(),
              const SizedBox(height: 10),
              _printCertificationAndReleased(),
              const SizedBox(height: 10),
              _printDescription(),
              const SizedBox(height: 10),
              _generateMembers(title: 'Actors', list: movie.actors, imageURL: AssetPath.ACTORS),
              _generateMembers(title: 'Crews', list: movie.crews, imageURL: AssetPath.CREW),
              SizedBox(height: deviceSize.height*0.08),
            ],
          ),
        ),
      )
    );
  }

  _getFloatingBookTicketsButton(){
    return Container(
        height: deviceSize.height*0.05,
        width: deviceSize.width*0.9,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(primary: MyTheme.splash),
          onPressed: (){
            Navigator.pushNamed(context, RouteConstants.BOOKING,arguments: {'movieName' : movie.title,'theatreName' : arguments['theatreName']});
          }, 
          child: Text(
            'Book Tickets',
            style: MyTheme.currentTheme.textTheme.displayMedium,
          )
      ),
    );
  }

  _printYoutubePlayer(){
    String id = Movie.convertToYoutubeID(movie.trailer);
    if(id.length > 12){
      return Container(
          height: deviceSize.height*0.2,
          margin: const EdgeInsets.only(left: 15,right: 15,top: 10),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10)),
            border: Border.all(width: 2,color: Colors.black),
            image: DecorationImage(image: NetworkImage(movie.trailer))
          ),
      );
    }
    else{
      YoutubePlayerController _controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(id)??'tOlsYCsXJdY',
      flags: const YoutubePlayerFlags(
          autoPlay: false,
          mute: false,
          forceHD: true,
      ),
    );
    return Column(
      children: [
        Container(
          width: deviceSize.width*0.92,
          height: deviceSize.height*0.2,
          margin: const EdgeInsets.only(top: 10,left: 15,right: 15),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10)),
            border: Border.all(width: 2,color: Colors.black)
          ),
          child: YoutubePlayer(
              controller: _controller,
          ),
        ),
        Container(
          height : deviceSize.height*0.025,
          width: deviceSize.width*0.92,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10),bottomRight: Radius.circular(10)),
            color: Colors.black
          ),
          child: Align(
            alignment: Alignment.center,
            child: Text('Trailer'.toUpperCase(),style: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
          )
        )
      ],
    );
    }
  }

  _printRating(){
    return Container(
      margin: const EdgeInsets.only(left: 15,right: 15),
      child: Row(
        children: [
          SvgPicture.asset('assets/icons/heart.svg'),
          const SizedBox(width: 5),
          Text(movie.imdb_rating,style: const TextStyle(color: Colors.red,fontSize: 20,fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  _printFramesAndLanguages(){
    return Container(
      margin: const EdgeInsets.only(left: 15,right: 15),
      child: Row(
        children: [
          _getGreyContainer(Text('2D',)),
          const SizedBox(width: 5),
          _getGreyContainer(
            Text('Original Language : ${movie.original_lang}'
          ))
        ],
      ),
    );
  }

  _getGreyContainer(Widget child){
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.grey.shade400,
      ),
      child: child,
    );
  }

  _printCertificationAndReleased(){
    return Container(
      margin: const EdgeInsets.only(left: 15,right: 15),
      child: Row(
        children: [
          _getTextBox('${movie.certification} • '),
          _getTextBox(movie.released_date)
        ],
      ),
    );
  }

  _getTextBox(text){
    return Text(text,
      style: MyTheme.currentTheme.textTheme.displaySmall,
    );
  }

  _printDescription(){
    return Container(
      margin: const EdgeInsets.only(left: 15,right: 15),
      child: Text(movie.description,style: MyTheme.DescriptionText)
      );
  }

  _generateMembers({required String title,required List<String> list,required String imageURL}){
    return Column(
      children: [
        const Divider(height: 1),
        const SizedBox(height: 5),
        Text(title.toUpperCase(),style: MyTheme.currentTheme.textTheme.displaySmall,),
        const SizedBox(height: 5),
        Container(
          height: deviceSize.height*0.22,
          child: ListView.builder(
            itemCount: list.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context,index){
              return Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Container(
                      width: deviceSize.width*0.3,
                      height: deviceSize.height*0.15,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(deviceSize.height*0.2),
                        image: DecorationImage(image: NetworkImage(imageURL),fit: BoxFit.fill)
                      ),
                    ),
                    SizedBox(height: 4,),
                    Text(list[index])
                  ],
                ),
              );
            }
          ),
        )
      ],
    );
  }

}

