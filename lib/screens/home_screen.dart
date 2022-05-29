import 'package:farming_using_ai_and_blockchain_front_end/controllers/weather_and_location_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'application_services_screens/application_services.dart';
import 'package:farming_using_ai_and_blockchain_front_end/color_constants.dart';
import 'package:farming_using_ai_and_blockchain_front_end/widgets/home_screen/option_banner.dart';
import 'package:farming_using_ai_and_blockchain_front_end/widgets/home_screen/top_banner.dart';
import 'package:farming_using_ai_and_blockchain_front_end/widgets/home_screen/weather_banner.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final WeatherAndLocationController locationController =
      Get.put(WeatherAndLocationController(), tag: "location");

  var _username = "...";
  static String _location = "not found";
  var _ethAddress;

  @override
  void initState() {
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
                        ethAddress: _ethAddress.toString(),
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
                  },
                  child: ListView.builder(
                    itemCount: options.length,
                    itemBuilder: (context, index) {
                      var _bg_source = options[index][0].toString();
                      var _serviceName = options[index][1].toString();
                      var _onTapAction = options[index][2];

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
}
