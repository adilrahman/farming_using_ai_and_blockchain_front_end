import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class WeatherAndLocationController extends GetxController {
  var location = "not yet found".obs;
  var count = 0.obs;

  getLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    print(" altitude  =========ddddddddddddddddddd===> ${position.longitude}");
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    print("place ===========> ${placemarks[0].subLocality}");
    location(
        "${placemarks[0].subLocality!}\n${placemarks[0].locality!}\n${placemarks[0].subAdministrativeArea!}");
  }
}
