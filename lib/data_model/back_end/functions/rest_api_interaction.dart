import 'dart:convert';
import 'dart:io';
import 'package:farming_using_ai_and_blockchain_front_end/controllers/weather_and_location_controller.dart';
import 'package:farming_using_ai_and_blockchain_front_end/data_model/back_end/models/fertilizer_recommendation_model.dart';
import 'package:farming_using_ai_and_blockchain_front_end/data_model/back_end/models/right_time_to_fertilizer_model.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' show get, post;
import 'package:farming_using_ai_and_blockchain_front_end/data_model/back_end/models/crop_recommendation_model.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

final WeatherAndLocationController locationController =
    Get.put(WeatherAndLocationController(), tag: "location");

class RestApiInteraction extends GetxController {
  RxBool isLoading = false.obs;
  final api = "https://reqres.in/api/users?page=2";
  final CROP_RECOMMENDATION_API = "http://192.168.43.135:8080/crop_recommend";
  final CROP_DISEASE_PREDICTION_API =
      "http://192.168.43.135:8080/crop_disease_predict";

  final RIGHT_TIME_TO_FERTILIZE_API =
      "http://192.168.43.135:8080/rightTimeToFertilize";

  final FERTILIZER_RECOMMENDATION_API =
      "http://192.168.43.135:8080/fertilizer_recommend";

  cropRecommentation(CropRecommendationModel _cropRecommendationModel) async {
    // http.Response response = await http.get(Uri.parse(CROP_RECOMMENDATION_API));
    // var result = jsonDecode(response.body);
    // print(" RESPONSE : ${result}");

    var jsonInput = jsonEncode(_cropRecommendationModel.toJson());
    print(jsonInput);
    print("some some some some some some some some soem");
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
    print(res);
    return json.decode(res.body);
  }

  cropDiseasePrediction(File _imageFile) async {
    var req =
        http.MultipartRequest("POST", Uri.parse(CROP_DISEASE_PREDICTION_API));
    req.headers['accept'] = 'application/json';
    req.headers['Content-Type'] = 'multipart/form-data';
    // print(
    // "object objectobjectobjectobjectobjectobjectobjectobjectobjectobjectobjectobjectobjectobjectobjectobjectobjectobjectobjectobjectobjectobject");
    // var img = http.MultipartFile(
    //   "file",
    //   _imageFile.readAsBytes().asStream(),
    //   _imageFile.lengthSync(),
    //   contentType: MediaType('image', 'png'),
    // );

    // req.files.add(img);

    req.files.add(
      await http.MultipartFile.fromPath(
        'file', // NOTE - this value must match the 'file=' at the start of -F
        _imageFile.path,
        contentType: MediaType('image', 'jpeg'),
      ),
    );

    final response = await http.Response.fromStream(await req.send());
    print(response.body);
  }

  rightTimeToFertilize() async {
    isLoading.value = true;
    var location = await locationController.getCurrentLocation();
    print(location);
    // location[0] -> lat
    // location[1] -> long
    TimeToFertilize _timeToFertilize = TimeToFertilize(
        latitude: location[0].toString(), longitude: location[1].toString());

    var jsonInput = jsonEncode(_timeToFertilize.toJson());

    final res = await http.post(
      Uri.parse(
        RIGHT_TIME_TO_FERTILIZE_API,
      ),
      headers: {
        "accept": "application/json",
        "Content-Type": "application/json"
      },
      body: jsonInput,
    );

    print(res.body + "sm999");
    isLoading.value = false;
    return json.decode(res.body);
  }

  fertilizerRecommentation(
      FertilizerRecommendationModel _fertilizerRecommendationModel) async {
    // http.Response response = await http.get(Uri.parse(CROP_RECOMMENDATION_API));
    // var result = jsonDecode(response.body);
    // print(" RESPONSE : ${result}");

    var jsonInput = jsonEncode(_fertilizerRecommendationModel.toJson());
    print(jsonInput);
    print("some some some some some some some some soem");
    final res = await http.post(
      Uri.parse(
        FERTILIZER_RECOMMENDATION_API,
      ),
      headers: {
        "accept": "application/json",
        "Content-Type": "application/json"
      },
      body: jsonInput,
    );
    print(res);
    return json.decode(res.body);
  }
}
