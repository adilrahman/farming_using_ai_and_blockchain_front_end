import 'package:farming_using_ai_and_blockchain_front_end/color_constants.dart';
import 'package:farming_using_ai_and_blockchain_front_end/controllers/weather_and_location_controller.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class WeatherBanner extends StatelessWidget {
  WeatherBanner({
    Key? key,
    required temp,
    required humidity,
    required rain_fall,
    required windSpeed,
  })  : _temp = temp,
        _humidity = humidity,
        _rain_fall = rain_fall,
        _windSpeed = windSpeed,
        super(key: key);
  WeatherAndLocationController _locationController = Get.find(tag: "location");
  var _temp;
  var _humidity;
  var _rain_fall;
  var _windSpeed;

  @override
  Widget build(BuildContext context) {
    return Container(
      //weather display
      margin: const EdgeInsets.only(top: 140, left: 10, right: 10),
      padding: const EdgeInsets.only(left: 10, top: 10, right: 10),
      width: MediaQuery.of(context).size.width,
      height: 250,
      decoration: BoxDecoration(
          color: AppColor.homePageBackground,
          boxShadow: const [
            BoxShadow(
                blurRadius: 45, offset: Offset(20, 20), color: Colors.black45),
          ],
          borderRadius: const BorderRadius.all(Radius.circular(10))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              child: Row(
            children: [
              Expanded(
                  child: Center(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      FontAwesomeIcons.temperatureHigh,
                      color: Colors.black,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Stack(
                      children: [
                        Obx(() => Text(
                              "${_locationController.temp.toString()}\nTemperature",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 12),
                            )),
                      ],
                    )
                  ],
                ),
              )),
              Expanded(
                  child: Center(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      FontAwesomeIcons.dragon,
                      color: Colors.black,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Stack(
                      children: [
                        Text(
                          "${_humidity.toString()}\nHumidity",
                          style: TextStyle(color: Colors.black, fontSize: 12),
                        ),
                      ],
                    )
                  ],
                ),
              ))
            ],
          )),
          Expanded(
              child: Row(
            children: [
              Expanded(
                  child: Center(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      FontAwesomeIcons.cloudRain,
                      color: Colors.black,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Stack(
                      children: [
                        Text(
                          "${_rain_fall.toString()}\nRain fall",
                          style: TextStyle(color: Colors.black, fontSize: 12),
                        ),
                      ],
                    )
                  ],
                ),
              )),
              Expanded(
                  child: Center(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      FontAwesomeIcons.wind,
                      color: Colors.black,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Stack(
                      children: [
                        Text(
                          "${_windSpeed.toString()}\nWindSpeed",
                          style: TextStyle(color: Colors.black, fontSize: 12),
                        ),
                      ],
                    )
                  ],
                ),
              ))
            ],
          )),
        ],
      ),
    );
  }
}
