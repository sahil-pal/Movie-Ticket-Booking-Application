import 'package:bigboxo_application/config/routes/app_routes.dart';
import 'package:bigboxo_application/core/auth/screens/login.dart';
import 'package:bigboxo_application/core/introduction/screens/splash.dart';
import 'package:bigboxo_application/modules/booking/cubit/booking_cubit.dart';
import 'package:bigboxo_application/modules/booking/repo/theatre_repo.dart';
import 'package:bigboxo_application/modules/home/cubit/search_cubit.dart';
import 'package:bigboxo_application/modules/home/repo/movie_operations.dart';
import 'package:bigboxo_application/modules/payment/cubit/payment_cubit.dart';
import 'package:bigboxo_application/modules/payment/repo/ticket_repo.dart';
import 'package:bigboxo_application/utils/services/local_notifications.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'config/themes/mytheme.dart';
import 'core/auth/bloc/auth_bloc.dart';
import 'core/auth/repo/auth_repo.dart';
import 'modules/home/screens/home.dart';

// background message receiver
Future<void> backgroundHandler(RemoteMessage message) async{
  print('Inside background');
}

void main() async {
  await dotenv.load(fileName: ".env");
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  runApp(MaterialApp(
    home: const MyApp(),
    title: 'BigBoxo',
    theme: MyTheme.myLightTheme,
    debugShowCheckedModeBanner: false,
    routes: getRoutes(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({ Key? key }) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  late BuildContext ctx = context;
  
  @override
  void initState() {
    super.initState();

    LocalNotificationService.intialize(ctx);
    // firebase messaging
    FirebaseMessaging.instance.getInitialMessage();

    //foreground work
    FirebaseMessaging.onMessage.listen((message) {
      LocalNotificationService.display(message);
    });

    // when app is in background and opened
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      LocalNotificationService.display(message);
    });
  }

  @override
  Widget build(BuildContext context) {
    ctx = context;
    SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
    ]);
    return RepositoryProvider(
      create: (context) => AuthRepository(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => AuthBloc(authRepository: RepositoryProvider.of<AuthRepository>(context))),
          BlocProvider(create: (context) => SearchCubit(movieOperations: MovieOperations.getMovieOperationInstance())),
          BlocProvider(create: (context) => BookingCubit(theatreOperations: TheatreOperations.getTheatreOperationsInstance())),
          BlocProvider(create: (context) => PaymentCubit(ticketOperations: TicketOperations.getTicketOprInstance())),
        ],
        child: MaterialApp(
          title: 'BigBoxo',
          theme: MyTheme.myLightTheme,
          debugShowCheckedModeBanner: false,
          routes: getRoutes(),
          home: StreamBuilder<User?>(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, snapshot) {
                // If the snapshot has user data, then they're already signed in. So Navigating to the Dashboard.
                if (snapshot.hasData) {
                  return SplashScreen(const HomeScreen());
                }
                // Otherwise, they're not signed in. Show the sign in page.
                return SplashScreen(LoginScreen());
            }
          ),
        )
      )   
    );
  }
}