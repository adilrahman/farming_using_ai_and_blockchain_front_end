import 'package:farming_using_ai_and_blockchain_front_end/color_constants.dart';
import 'package:farming_using_ai_and_blockchain_front_end/data_model/back_end/functions/rest_api_interaction.dart';
import 'package:farming_using_ai_and_blockchain_front_end/data_model/back_end/models/fertilizer_recommendation_model.dart';
import 'package:farming_using_ai_and_blockchain_front_end/screens/application_services_screens/fertilizer_recommendatoin_screens/response_view_screen.dart';
import 'package:farming_using_ai_and_blockchain_front_end/screens/application_services_screens/fertilizer_recommendatoin_screens/widgets/text_fields.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FertilizerRecommendationScreen extends StatefulWidget {
  const FertilizerRecommendationScreen({Key? key}) : super(key: key);

  @override
  State<FertilizerRecommendationScreen> createState() =>
      _FertilizerRecommendationScreenState();
}

class _FertilizerRecommendationScreenState
    extends State<FertilizerRecommendationScreen> {
  final RestApiInteraction backendInterFace =
      Get.put(RestApiInteraction(), tag: "backend");

  final TextEditingController _nitrogenRatioEditingController =
      TextEditingController();

  final TextEditingController _phosphorusRatioEditingController =
      TextEditingController();

  final TextEditingController _potassiumRatioEditingController =
      TextEditingController();

  final TextEditingController _cropEditingController = TextEditingController();

  String _value1 = "";
  String _value2 = "";

  final List<String> nameList = <String>[
    "Name1",
    "Name2",
    "Name3",
    "Name4",
    "Name5",
    "Name6",
    "Name7",
    "Name8"
  ];

  @override
  void initState() {
    super.initState();
    _value1 = nameList[0];
    _value2 = nameList[3];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.gradientSecond,
        title: const Text("fertilizer recommendation"),
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
                      // "rainfall value must be either float or integer");
                      sendRequest();
                    },
                    child: Container(
                      child: const Center(child: Text("Predict")),
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

    var result = await backendInterFace.fertilizerRecommentation(tmp) as List;

    Get.to(
        ResponseViewScreen(
          response: result,
        ),
        transition: Transition.fadeIn,
        duration: const Duration(seconds: 1));
  }
}
