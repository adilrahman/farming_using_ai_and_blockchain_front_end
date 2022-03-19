import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:farming_using_ai_and_blockchain_front_end/color_constants.dart';
import 'package:farming_using_ai_and_blockchain_front_end/palatte.dart';
import 'package:farming_using_ai_and_blockchain_front_end/widgets/home_screen/settings_button.dart';
import 'package:farming_using_ai_and_blockchain_front_end/widgets/home_screen/option_banner.dart';
import 'package:farming_using_ai_and_blockchain_front_end/widgets/home_screen/top_banner.dart';
import 'package:farming_using_ai_and_blockchain_front_end/widgets/home_screen/weather_banner.dart';
import 'package:farming_using_ai_and_blockchain_front_end/widgets/loading.dart';
import 'package:farming_using_ai_and_blockchain_front_end/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var _username = "Adil rahman";
  static String _location = "not found";
  final _temp = "67 f";
  final _humidity = "61%";
  final _rain_fall = "0.0mm";
  final _windSpeed = "3.9m/s";

  static onTapAction() {
    print("=====================--------=> ${_location}");
  }

  static var options = [
    [
      "assets/images/bg_plant_disease_detection.jpg",
      "Plant Disease Detection",
      onTapAction
    ],
    [
      "assets/images/bg_crop_recommendation.jpeg",
      "Crop Recommendation",
      onTapAction
    ],
    [
      "assets/images/bg_ferilizer_recommendation.jpg",
      "Fertilizer Recommendation",
      onTapAction
    ],
    [
      "assets/images/bg_time_to_fertilize.jpg",
      "Time to Fertilize",
      onTapAction
    ],
    ["assets/images/bg_crowdfunding.jpeg", "Crowdfunding", onTapAction],
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.homePageBackground,
      body: Container(
        padding: const EdgeInsets.only(),
        child: Column(
          children: [
            Stack(
              children: [
                TopBanner(username: _username, location: _location),
                WeatherBanner(
                    temp: _temp,
                    humidity: _humidity,
                    rain_fall: _rain_fall,
                    windSpeed: _windSpeed),
              ],
            ),
            Expanded(
                child: ListView.builder(
              itemCount: options.length,
              itemBuilder: (context, index) {
                var _bg_source = options[index][0].toString();
                var _serviceName = options[index][1].toString();
                var _onTapAction = options[index][2];
                print(_bg_source);

                return OptionBanner(
                  bg_source: _bg_source,
                  serviceName: _serviceName,
                  onTapAction: _onTapAction,
                );
              },
            ))
          ],
        ),
      ),
    );
  }

  // Future<Placemark> getPosition() async {
  //   setState(() {
  //     isLoading = true;
  //   });
  //   Position position = await Geolocator.getCurrentPosition(
  //       desiredAccuracy: LocationAccuracy.high);
  //   print(" altitude  ============> ${position.longitude}");
  //   List<Placemark> placemarks =
  //       await placemarkFromCoordinates(position.latitude, position.longitude);
  //   print("place ===========> ${placemarks[0].subLocality}");
  //   setState(() {
  //     _location = "${position.longitude}";
  //     isLoading = false;
  //   });
  //   return placemarks[0];
  // }
}
