import 'package:bigboxo_application/config/constants/app_constants.dart';
import 'package:bigboxo_application/config/themes/mytheme.dart';
import 'events_list.dart';
import 'movies_list.dart';
import 'offer_carousel.dart';
import 'plays_list.dart';
import 'menu_items.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import '../../../core/auth/bloc/auth_bloc.dart';
import '../../../core/auth/bloc/auth_state.dart';
import 'shows_list.dart';

class HomeWidget extends StatelessWidget {
  const HomeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthBloc authBloc = BlocProvider.of<AuthBloc>(context);
    Size _size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      //padding: const EdgeInsets.only(left: 20.0, top: 10, right: 10),
      height: _size.height,
      width: _size.width,
      child: SingleChildScrollView(
        child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                  padding: const EdgeInsets.only(left: 20.0, top: 10),
                  child: Text('seat categories'.toUpperCase(),
                      style: MyTheme.currentTheme.textTheme.headline3)),
              const MenuItems(),
              //_printHeading(
                  //svgName: 'recommended_movies', heading: 'Recommended movies'),
              //const MovieList(),
              _printCarouselBox(),
              // _printHeading(svgName: 'recommended_movies', heading: 'shows'),
              // const ShowList(),
              _printHeading(svgName: 'spotlights', heading: 'events'),
              const EventList(),
              _printHeading(svgName: 'theater_masks', heading: 'plays'),
              const PlayList(),
            ]),
      ),
    );
  }

  _printCarouselBox() {
    return Container(
      height: 205,
      color: Colors.black.withOpacity(0.8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'new offers'.toUpperCase(),
            style: MyTheme.currentTheme.textTheme.headline4,
          ),
          OffersCarousel()
        ],
      ),
    );
  }

  _printHeading({required String svgName, required String heading}) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, top: 5, right: 10),
      child: Row(
        children: [
          _getSvg(svgName),
          const SizedBox(width: 5),
          _getSectionHeading(heading),
          const Spacer(),
          TextButton(
            onPressed: () {},
            child:
                const Text("View All", style: TextStyle(color: MyTheme.splash)),
          ),
        ],
      ),
    );
  }

  _getSvg(String name) {
    return SvgPicture.asset(
      "assets/icons/$name.svg",
      color: Colors.black.withOpacity(0.8),
      height: 18,
      width: 18,
    );
  }

  _getSectionHeading(String heading) {
    return Text(
      heading.toUpperCase(),
      style: MyTheme.currentTheme.textTheme.headline5,
    );
  }
}
