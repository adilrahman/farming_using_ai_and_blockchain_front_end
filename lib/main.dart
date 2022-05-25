import 'package:farming_using_ai_and_blockchain_front_end/screens/application_services_screens/crowd_funding/crowd_funding.dart';
import 'package:farming_using_ai_and_blockchain_front_end/screens/investors_screen/investors_screen.dart';
import 'package:farming_using_ai_and_blockchain_front_end/screens/screens.dart';
import 'package:farming_using_ai_and_blockchain_front_end/screens/settings/settings_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'screens/application_services_screens/crowd_funding/detailed_project_view_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool? isInvesterLogged = false;
  bool? isUserLogged = false;

  isInvesterLogged = prefs.getBool('investerLogged');
  isUserLogged = prefs.getBool('userLogged');
  await Firebase.initializeApp();

  if (isInvesterLogged == true) {
    String _username = prefs.getString('username')!;
    String _ethAddress = prefs.getString('ethAddress')!;

    final loginfo = LogInfo(userName: _username, etherAddress: _ethAddress);

    runApp(GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Agro App',
        themeMode: ThemeMode.light,
        theme:
            ThemeData(brightness: Brightness.dark, primaryColor: Colors.green),
        home: InvestorsScreen(logInfo: loginfo)));
  } else if (isUserLogged == true) {
    runApp(GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Agro App',
        themeMode: ThemeMode.light,
        theme:
            ThemeData(brightness: Brightness.dark, primaryColor: Colors.green),
        home: HomeScreen()));
  } else {
    runApp(MyApp());
  }

  // whenever your initialization is completed, remove the splash screen:
  FlutterNativeSplash.remove();
  // WeatherAndLocationController _locationController = Get.find(tag: "location");
  // await _locationController.getCurrentWeatherData()();
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  User? user;

  final LiquidController _liquidController = LiquidController();
  // TODO : for the liquid swipe
  // final pages = [
  //   SignInScreen(),
  //   InvestorsSignInScreen(),
  // ];
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Agro App',
        themeMode: ThemeMode.light,
        theme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: Colors.green,
        ),
        home: Scaffold(
          // backgroundColor: Colors.black,
          body: Builder(builder: (context) {
            return LiquidSwipe(
                liquidController: _liquidController,
                positionSlideIcon: 0.8,
                enableLoop: true,
                initialPage: 0,
                waveType: WaveType.liquidReveal,
                slideIconWidget: const Icon(Icons.arrow_back_ios),
                pages: [
                  SafeArea(child: SignInOrSignUp()),
                  InvestorsSignInScreen(),
                ]);
          }),
        ));
  }
}
