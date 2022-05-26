import 'package:farming_using_ai_and_blockchain_front_end/color_constants.dart';
import 'package:farming_using_ai_and_blockchain_front_end/controllers/weather_and_location_controller.dart';
import 'package:farming_using_ai_and_blockchain_front_end/widgets/home_screen/settings_button.dart';
import 'package:farming_using_ai_and_blockchain_front_end/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class TopBanner extends StatefulWidget {
  TopBanner({
    Key? key,
    required String username,
    required String location,
  })  : _username = username,
        _location = location,
        super(key: key);

  final String _username;
  var _location;

  @override
  State<TopBanner> createState() => _TopBannerState();
}

class _TopBannerState extends State<TopBanner> {
  WeatherAndLocationController _locationController = Get.find(tag: "location");
  var location = "not found";
  @override
  void initState() {
    super.initState();
    _locationController.getCurrentWeatherData();

    location = _locationController.location.value;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 5),
      height: 260,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColor.gradientFirst.withOpacity(0.95),
            AppColor.gradientSecond.withOpacity(0.8),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        children: [
          const SizedBox(height: 10),
          const SettingsButton(),
          const SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  child: Container(
                child: Row(
                  children: [
                    const Icon(
                      FontAwesomeIcons.user,
                      size: 19,
                    ),
                    Text(
                      " ${widget._username}",
                      style: TextStyle(
                          color: AppColor.homePageContainerTextBig,
                          fontWeight: FontWeight.w300,
                          fontSize: 20),
                    )
                  ],
                ), //Username
              )),
              Expanded(
                  child: Obx(() => Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const Icon(
                              Icons.my_location_sharp,
                              size: 20,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            _locationController.isWeatherDataLoading == true
                                ? const LocationDataLoading()
                                : Text(
                                    _locationController.location.value
                                        .toString(),
                                    style: const TextStyle(fontSize: 11),
                                  )
                          ],
                        ),
                      )))
            ],
          ),
        ],
      ),
    );
  }

  Future<Placemark> getPosition() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);

    return placemarks[0];
  }
}
