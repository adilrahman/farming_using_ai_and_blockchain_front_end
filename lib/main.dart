import 'package:farming_using_ai_and_blockchain_front_end/screens/investors_sign_in.dart';
import 'package:farming_using_ai_and_blockchain_front_end/screens/screens.dart';
import 'package:farming_using_ai_and_blockchain_front_end/screens/sign_in_or_sign_up.dart';
import 'package:flutter/material.dart';
import 'package:liquid_swipe/liquid_swipe.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final LiquidController _liquidController = LiquidController();
// TODO : for the liquid swipe
  // final pages = [
  //   SignInScreen(),
  //   InvestorsSignInScreen(),
  // ];
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Agro App',
        themeMode: ThemeMode.dark,
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
                initialPage: 2,
                waveType: WaveType.liquidReveal,
                slideIconWidget: Icon(Icons.arrow_back_ios),
                pages: [
                  SafeArea(child: SignInOrSignUp()),
                  InvestorsSignInScreen(),
                  HomeScreen()
                ]);
          }),
        ));
  }
}
