import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

// contains all loading widgets
//
class MainLoading extends StatelessWidget {
  const MainLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 0, right: 10),
      child: const SpinKitThreeInOut(
        color: Colors.black87,
        size: 20,
      ),
    );
  }
}

class WeatherDataLoading extends StatelessWidget {
  const WeatherDataLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 0, right: 10),
      child: const SpinKitThreeBounce(
        color: Colors.grey,
        size: 20,
      ),
    );
  }
}

class LocationDataLoading extends StatelessWidget {
  const LocationDataLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 0, right: 10),
      child: const SpinKitFadingFour(
        color: Colors.white,
        size: 20,
      ),
    );
  }
}
