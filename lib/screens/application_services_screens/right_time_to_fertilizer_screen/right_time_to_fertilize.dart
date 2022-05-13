import 'package:farming_using_ai_and_blockchain_front_end/color_constants.dart';
import 'package:farming_using_ai_and_blockchain_front_end/controllers/weather_and_location_controller.dart';
import 'package:farming_using_ai_and_blockchain_front_end/data_model/back_end/functions/rest_api_interaction.dart';
import 'package:farming_using_ai_and_blockchain_front_end/data_model/back_end/models/right_time_to_fertilizer_model.dart';
import 'package:farming_using_ai_and_blockchain_front_end/screens/application_services_screens/right_time_to_fertilizer_screen/widgets/custom_dialog_box.dart';
import 'package:farming_using_ai_and_blockchain_front_end/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RightTimeToFertilize extends StatelessWidget {
  RightTimeToFertilize({Key? key}) : super(key: key);

  final RestApiInteraction backendInterFace =
      Get.put(RestApiInteraction(), tag: "backend");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.homePageBackground,
      appBar: AppBar(
        title: Text("Time to fertilize"),
        centerTitle: true,
        backgroundColor: AppColor.gradientSecond,
      ),
      body: Container(
        child: Obx(() => Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: backendInterFace.isLoading.value
                      ? APILoading()
                      : ElevatedButton(
                          onPressed: () async {
                            predict(context);
                          },
                          child: Text("Predict")),
                )
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
