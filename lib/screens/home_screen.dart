import 'package:farming_using_ai_and_blockchain_front_end/controllers/weather_and_location_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'application_services_screens/application_services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'application_services_screens/crop_recommentation_screens/crop_recommendation.dart';
import 'application_services_screens/plant_disease_detection_screens/plant_disease_detection.dart';
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

import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final WeatherAndLocationController locationController =
      Get.put(WeatherAndLocationController(), tag: "location");

  var _username = "...";
  static String _location = "not found";
  var _ethAddress;

  static onTapAction() {
    print("=====================--------=> ${_location}");
  }

  @override
  void initState() {
    // TODO: implement initState
    retriveUserData();
    super.initState();
  }

  retriveUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _username = prefs.getString("username")!;
      _ethAddress = prefs.getString("ethAddress")!;
    });
  }

  @override
  Widget build(BuildContext context) {
    var options = [
      const [
        "assets/images/bg_plant_disease_detection.jpg",
        "Plant Disease Detection",
        PlantDiseaseDetectionScreen()
      ],
      [
        "assets/images/bg_crop_recommendation.jpeg",
        "Crop Recommendation",
        CropRecommendationScreen()
      ],
      [
        "assets/images/bg_ferilizer_recommendation.jpg",
        "Fertilizer Recommendation",
        FertilizerRecommendationScreen()
      ],
      [
        "assets/images/bg_time_to_fertilize.jpg",
        "Time to Fertilize",
        RightTimeToFertilize()
      ],
      [
        "assets/images/bg_crowdfunding.jpeg",
        "Crowdfunding",
        CrowdFundingScreen(username: _username, ethAddress: _ethAddress),
      ],
    ];

    return Obx(() => Scaffold(
          backgroundColor: AppColor.homePageBackground,
          body: Container(
            padding: const EdgeInsets.only(),
            child: Column(
              children: [
                Stack(
                  children: [
                    TopBanner(
                        username: _username,
                        location: locationController.location.value),
                    WeatherBanner(
                        temp: locationController.temp,
                        humidity: locationController.humidity,
                        rain_fall: locationController.rainFall,
                        windSpeed: locationController.windSpeed)
                  ],
                ),
                Expanded(
                    child: RefreshIndicator(
                  onRefresh: () async {
                    // await locationController.getLocation();
                    await locationController.getCurrentWeatherData();

                    print(
                        " new freas ======== > ${locationController.location.value} ");
                    print(
                        "= ================================>  ${locationController.humidity}    <==========================================");
                  },
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
                        goToPage: _onTapAction,
                      );
                    },
                  ),
                ))
              ],
            ),
          ),
        ));
  }

  // Future<Placemark> getPosition() async {
  //   Position position = await Geolocator.getCurrentPosition(
  //       desiredAccuracy: LocationAccuracy.high);
  //   print(" altitude  ============> ${position.longitude}");
  //   List<Placemark> placemarks =
  //       await placemarkFromCoordinates(position.latitude, position.longitude);
  //   print("place ===========> ${placemarks[0].subLocality}");

  //   return placemarks[0];
  // }
}
