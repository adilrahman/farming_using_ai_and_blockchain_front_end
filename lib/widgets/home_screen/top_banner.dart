import 'dart:ui';

import 'package:farming_using_ai_and_blockchain_front_end/color_constants.dart';
import 'package:farming_using_ai_and_blockchain_front_end/widgets/home_screen/settings_button.dart';
import 'package:flutter/material.dart';

class TopBanner extends StatelessWidget {
  const TopBanner({
    Key? key,
    required String username,
    required String location,
  })  : _username = username,
        _location = location,
        super(key: key);

  final String _username;
  final String _location;

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
          SizedBox(height: 10),
          SettingsButton(),
          SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  child: Container(
                // padding: EdgeInsets.only(left: 20, top: 20),
                child: Text(
                  "Hello, ${_username}",
                  style: TextStyle(
                      color: AppColor.homePageContainerTextBig,
                      fontWeight: FontWeight.w400,
                      fontSize: 20),
                ), //Username
              )),
              Expanded(
                  child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(
                      Icons.my_location_sharp,
                      size: 14,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      "${_location}",
                      style: TextStyle(fontSize: 12),
                    )
                  ],
                ),
              ))
            ],
          ),
        ],
      ),
    );
  }
}
