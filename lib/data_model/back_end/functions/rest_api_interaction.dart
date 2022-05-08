import 'dart:convert';
import 'package:http/http.dart' show get, post;
import 'package:farming_using_ai_and_blockchain_front_end/data_model/back_end/models/crop_recommendation_model.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:http/http.dart' as http;

class RestApiInteraction extends GetxController {
  final api = "https://reqres.in/api/users?page=2";

  cropRecommentation(CropRecommendationModel _cropRecommendationModel) async {
    final CROP_RECOMMENDATION_API = "http://192.168.43.135:8080/crop_recommend";

    // http.Response response = await http.get(Uri.parse(CROP_RECOMMENDATION_API));
    // var result = jsonDecode(response.body);
    // print(" RESPONSE : ${result}");

    var jsonInput = jsonEncode(_cropRecommendationModel.toJson());
    print(jsonInput);

    final res = await http.post(
      Uri.parse(
        CROP_RECOMMENDATION_API,
      ),
      headers: {
        "accept": "application/json",
        "Content-Type": "application/json"
      },
      body: jsonInput,
    );
    return json.decode(res.body);
  }
}
