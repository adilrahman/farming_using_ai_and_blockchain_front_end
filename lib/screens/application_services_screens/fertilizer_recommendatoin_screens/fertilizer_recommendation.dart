import 'package:farming_using_ai_and_blockchain_front_end/color_constants.dart';
import 'package:farming_using_ai_and_blockchain_front_end/data_model/back_end/functions/rest_api_interaction.dart';
import 'package:farming_using_ai_and_blockchain_front_end/data_model/back_end/models/fertilizer_recommendation_model.dart';
import 'package:farming_using_ai_and_blockchain_front_end/screens/application_services_screens/fertilizer_recommendatoin_screens/response_view_screen.dart';
import 'package:farming_using_ai_and_blockchain_front_end/screens/application_services_screens/fertilizer_recommendatoin_screens/widgets/text_fields.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FertilizerRecommendationScreen extends StatelessWidget {
  FertilizerRecommendationScreen({Key? key}) : super(key: key);

  final RestApiInteraction backendInterFace =
      Get.put(RestApiInteraction(), tag: "backend");

  final TextEditingController _nitrogenRatioEditingController =
      TextEditingController();
  final TextEditingController _phosphorusRatioEditingController =
      TextEditingController();
  final TextEditingController _potassiumRatioEditingController =
      TextEditingController();
  final TextEditingController _cropEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.gradientSecond,
      ),
      body: Scaffold(
        backgroundColor: AppColor.homePageBackground,
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
                      titleEditingController: _cropEditingController,
                      hintText: "crop"),
                  const SizedBox(height: 10),
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
        ),
      ),
    );
  }

  sendRequest() async {
    var n = int.parse(_nitrogenRatioEditingController.text);
    var p = int.parse(_phosphorusRatioEditingController.text);
    var k = int.parse(_potassiumRatioEditingController.text);
    var crop = _cropEditingController.text;

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
    if (k == null) {
      Get.snackbar("Value Error", "potassium ratio must be an integer");
      return;
    }

    FertilizerRecommendationModel tmp = FertilizerRecommendationModel(
      n: n.toString(),
      p: p.toString(),
      k: k.toString(),
      crop: crop.toString(),
    );

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
    var result = await backendInterFace.fertilizerRecommentation(tmp) as List;
    print(result);
    Get.to(
        ResponseViewScreen(
          response: result,
        ),
        transition: Transition.fadeIn,
        duration: Duration(seconds: 1));
  }
}
