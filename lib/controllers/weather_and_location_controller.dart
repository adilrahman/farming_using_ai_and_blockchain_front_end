import 'dart:convert';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:http/http.dart' as http;

class WeatherAndLocationController extends GetxController {
  var location = "not yet found".obs;
  var count = 0.obs;
  var _longitude;
  var _latitude;

  var temp = "0.0".obs;
  var humidity = "0".obs;
  var rainFall = "0.0".obs;
  var windSpeed = "0.0".obs;
  RxBool isWeatherDataLoading = true.obs;
  RxBool isLocationDataLoading = true.obs;

  getLocation() async {
    isLocationDataLoading.value = true;
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    // print(" altitude  =========ddddddddddddddddddd===> ${position.longitude}");
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    // print("place ===========> ${placemarks[0].subLocality}");
    location(
        "${placemarks[0].subLocality!}\n${placemarks[0].locality!}\n${placemarks[0].subAdministrativeArea!}\n");
    _longitude = position.longitude;
    _latitude = position.latitude;
    isLocationDataLoading.value = false;
  }

  getCurrentWeatherData() async {
    isWeatherDataLoading.value = true;
    await getLocation();

    var api =
        "https://api.openweathermap.org/data/2.5/weather?lat=$_latitude&lon=$_longitude&appid=2192e457bb9626a4ee6892c77e298054";
    http.Response response = await http.get(Uri.parse(api));
    var result = jsonDecode(response.body);

    humidity(result["main"]["humidity"].toString() + "%");
    temp((result['main']['temp']).toString() + "K");
    windSpeed(result["wind"]["speed"].toString() + "m/s");
    rainFall(result["clouds"]["all"].toString() + "%");
    isWeatherDataLoading.value = false;
  }
}
