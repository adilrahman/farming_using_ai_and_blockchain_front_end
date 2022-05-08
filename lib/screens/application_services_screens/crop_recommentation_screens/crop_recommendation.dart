import 'package:farming_using_ai_and_blockchain_front_end/color_constants.dart';
import 'package:farming_using_ai_and_blockchain_front_end/data_model/back_end/functions/rest_api_interaction.dart';
import 'package:farming_using_ai_and_blockchain_front_end/data_model/back_end/models/crop_recommendation_model.dart';
import 'package:farming_using_ai_and_blockchain_front_end/screens/application_services_screens/crop_recommentation_screens/response_view_screen.dart';
import 'package:farming_using_ai_and_blockchain_front_end/screens/application_services_screens/crop_recommentation_screens/widgets/text_boxes.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

final RestApiInteraction backendInterFace =
    Get.put(RestApiInteraction(), tag: "backend");

class CropRecommendationScreen extends StatelessWidget {
  CropRecommendationScreen({Key? key}) : super(key: key);

  final TextEditingController _nitrogenRatioEditingController =
      TextEditingController();
  final TextEditingController _phosphorusRatioEditingController =
      TextEditingController();
  final TextEditingController _potassiumRatioEditingController =
      TextEditingController();
  final TextEditingController _temperatureEditingController =
      TextEditingController();
  final TextEditingController _humidityEditingController =
      TextEditingController();
  final TextEditingController _pHEditingController = TextEditingController();
  final TextEditingController _rainfallEditingController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.homePageBackground,
        appBar: AppBar(
          backgroundColor: AppColor.gradientSecond,
          title: Text("Crop Recommendation"),
          centerTitle: true,
        ),
        body: Container(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  singleTextField(
                      titleEditingController: _nitrogenRatioEditingController,
                      hintText: "Nitrogen (N) ratio content in soil"),
                  const SizedBox(height: 10),
                  singleTextField(
                      titleEditingController: _phosphorusRatioEditingController,
                      hintText: "Phosphorus (P) ratio content in soil"),
                  const SizedBox(height: 10),
                  singleTextField(
                      titleEditingController: _potassiumRatioEditingController,
                      hintText: "Potassium (K) ratio content in soil"),
                  const SizedBox(height: 10),
                  singleTextField(
                      titleEditingController: _pHEditingController,
                      hintText: "pH value of the soil"),
                  const SizedBox(height: 10),
                  TextFieldWithSuffix(
                      titleEditingController: _temperatureEditingController,
                      suffixText: "C",
                      icon: Icons.gps_fixed_rounded,
                      hintText: "temperature in degree Celsius"),
                  const SizedBox(height: 10),
                  TextFieldWithSuffix(
                      titleEditingController: _humidityEditingController,
                      suffixText: "C",
                      icon: Icons.gps_fixed_rounded,
                      hintText: "humidity in %"),
                  const SizedBox(height: 10),
                  TextFieldWithSuffix(
                      titleEditingController: _rainfallEditingController,
                      suffixText: "mm",
                      icon: Icons.gps_fixed_rounded,
                      hintText: "rainfall in mm"),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      // Get.snackbar("OK",
                      // "rainfall value must be either float or integer");
                      sendRequest();
                    },
                    child: Container(
                      child: Center(child: Text("Predict")),
                      width: double.infinity,
                      height: 50,
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }

  sendRequest() async {
    var n = int.parse(_nitrogenRatioEditingController.text);
    var p = int.parse(_phosphorusRatioEditingController.text);
    var k = int.parse(_potassiumRatioEditingController.text);
    var pH = double.parse(_pHEditingController.text);
    var temp = double.parse(_temperatureEditingController.text);
    var humidity = double.parse(_humidityEditingController.text);
    var rainfall = double.parse(_rainfallEditingController.text);

    if (n == null) {
      Get.snackbar("Value Error", "nitrogen ratio must be an integer");
      return;
    }
    if (p == null) {
      Get.snackbar("Value Error", "phosphorus ratio must be an integer");
      return;
    }
    if (k == null) {
      Get.snackbar("Value Error", "potassium ratio must be an integer");
      return;
    }
    if (pH == null) {
      Get.snackbar("Value Error", "pH value must be either float or integer");
      return;
    }
    if (temp == null) {
      Get.snackbar(
          "Value Error", "temperature value must be either float or integer");
      return;
    }
    if (humidity == null) {
      Get.snackbar(
          "Value Error", "humidity value must be either float or integer");
      return;
    }
    if (rainfall == null) {
      Get.snackbar(
          "Value Error", "rainfall value must be either float or integer");
      return;
    }
    CropRecommendationModel tmp = CropRecommendationModel(
        n: n.toString(),
        p: p.toString(),
        k: k.toString(),
        pH: pH.toString(),
        humidity: humidity.toString(),
        rainFall: rainfall.toString(),
        temp: temp.toString());

    // var n = 90;
    // var p = 42;
    // var k = 43;
    // var pH = 7;
    // var humidity = 82;
    // var temp = 26;
    // var rainfall = 202;
    // CropRecommendationModel tmp1 = CropRecommendationModel(
    //     n: n.toString(),
    //     p: p.toString(),
    //     k: k.toString(),
    //     pH: pH.toString(),
    //     humidity: humidity.toString(),
    //     rainFall: rainfall.toString(),
    //     temp: temp.toString());
    var result = await backendInterFace.cropRecommentation(tmp) as List;
    print(result);
    Get.to(
        ResponseViewScreen(
          response: result,
        ),
        transition: Transition.fadeIn,
        duration: Duration(seconds: 1));
  }
}
