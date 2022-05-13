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

class ProjectFetchingLoading extends StatelessWidget {
  const ProjectFetchingLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 0, right: 0),
      child: const SpinKitPouringHourGlassRefined(
        color: Colors.grey,
        size: 70,
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

class APILoading extends StatelessWidget {
  const APILoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 0, right: 10),
      child: const SpinKitWave(
        color: Colors.blue,
        size: 30,
      ),
    );
  }
}
