import 'package:farming_using_ai_and_blockchain_front_end/color_constants.dart';
import 'package:farming_using_ai_and_blockchain_front_end/controllers/weather_and_location_controller.dart';
import 'package:farming_using_ai_and_blockchain_front_end/data_model/back_end/functions/rest_api_interaction.dart';
import 'package:farming_using_ai_and_blockchain_front_end/screens/application_services_screens/right_time_to_fertilizer_screen/widgets/custom_dialog_box.dart';
import 'package:farming_using_ai_and_blockchain_front_end/widgets/home_screen/weather_banner.dart';
import 'package:farming_using_ai_and_blockchain_front_end/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RightTimeToFertilize extends StatelessWidget {
  RightTimeToFertilize({Key? key}) : super(key: key);

  final RestApiInteraction backendInterFace =
      Get.put(RestApiInteraction(), tag: "backend");
  @override
  Widget build(BuildContext context) {
    final WeatherAndLocationController locationController =
        Get.put(WeatherAndLocationController(), tag: "location");
    return Scaffold(
      backgroundColor: AppColor.homePageBackground,
      appBar: AppBar(
        title: const Text("Time to fertilize"),
        centerTitle: true,
        backgroundColor: AppColor.gradientSecond,
      ),
      body: Container(
        padding: const EdgeInsets.only(bottom: 60),
        width: double.infinity,
        child: Obx(() => Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                WeatherBanner(
                    temp: locationController.temp,
                    humidity: locationController.humidity,
                    rain_fall: locationController.rainFall,
                    windSpeed: locationController.windSpeed),
                Expanded(child: Container()),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      child: backendInterFace.isLoading.value
                          ? const APILoading()
                          : Container(
                              width: 350,
                              child: ElevatedButton.icon(
                                  onPressed: () async {
                                    predict(context);
                                  },
                                  style: ElevatedButton.styleFrom(
                                      primary: AppColor.gradientSecond,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 15),
                                      textStyle: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500)),
                                  icon: const Icon(Icons.check),
                                  label: const Text("Check")),
                            ),
                    ),
                  ],
                ),
              ],
            )),
      ),
    );
  }

  predict(context) async {
    var result = await backendInterFace.rightTimeToFertilize();

    Color color = result["signal"] ? Colors.green : Colors.red;
    var icon = result["signal"] ? Icons.approval : Icons.disabled_by_default;
    var heading = result["signal"] ? "POSITIVE" : "NEGATIVE";
    var body = result["data"];
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AdvanceCustomAlert(
            heading: heading,
            data: body,
            icon: icon,
            color: color,
          );
        });
  }
}
