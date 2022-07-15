import 'package:bigboxo_application/config/constants/app_constants.dart';
import 'package:bigboxo_application/config/themes/mytheme.dart';
import 'package:bigboxo_application/modules/booking/repo/theatre_repo.dart';
import 'package:bigboxo_application/modules/home/screens/search.dart';
import 'package:bigboxo_application/modules/home/widgets/app_bar.dart';
import 'package:bigboxo_application/modules/profile/screens/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import '../../../core/auth/bloc/auth_bloc.dart';
import '../../../core/auth/bloc/auth_state.dart';
import '../widgets/home_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // for running sample
    // TheatreOperations to = TheatreOperations.getTheatreOperationsInstance();
    // to.addSample();
  }

  int currPageIndex = 0;

  List<Map<String, dynamic>> _loadAllPages() {
    return [
      {
        'page': const HomeWidget(),
        'title': 'Home',
        'icon': 'assets/icons/tickets.svg'
      },
      {
        'page': SearchScreen(),
        'title': 'Trump',
        'icon': 'assets/icons/cards.svg'
      },
      {
        'page': ProfileScreen(),
        'title': 'Profile',
        'icon': 'assets/icons/user_profile.svg'
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child:HomeAppBar()
        ),
        bottomNavigationBar: BottomNavigationBar(
            elevation: 0,
            currentIndex: currPageIndex,
            unselectedItemColor: Colors.black,
            backgroundColor: MyTheme.splash,
            selectedItemColor: Colors.white,
            onTap: (newIndex) {
              currPageIndex = newIndex;
              setState(() {});
            },
            items: _loadAllPages().map((e) {
              return BottomNavigationBarItem(
                  icon: _getSvgIcon(name: e['icon']), label: e['title']);
            }).toList()),
        body: BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is UnAuthenticated) {
                Navigator.restorablePopAndPushNamed(
                    context, RouteConstants.LOGIN);
              }
            },
            child:
                SafeArea(child: _loadAllPages()[currPageIndex]['page']))));
  }

  _getSvgIcon({required String name}) {
    return SvgPicture.asset(
      name,
      height: 20,
    );
  }

  _printAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: MyTheme.splash,
      toolbarHeight: 50,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(AppConstants.APP_NAME.toUpperCase(),
              style: MyTheme.currentTheme.textTheme.displayLarge),
          Text(
            AppConstants.APP_TAGLINE,
            style: MyTheme.currentTheme.textTheme.bodySmall,
          )
        ],
      ),
      actions: [
        Container(
            margin: const EdgeInsets.only(right: 20),
            child: const Icon(
              Icons.notifications_none_outlined,
              size: 25,
            ))
      ],
    );
  }
}
