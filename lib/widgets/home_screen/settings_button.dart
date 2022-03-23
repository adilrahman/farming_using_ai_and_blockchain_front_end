import 'package:farming_using_ai_and_blockchain_front_end/color_constants.dart';
import 'package:farming_using_ai_and_blockchain_front_end/screens/settings/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class SettingsButton extends StatelessWidget {
  const SettingsButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Container()),
        Container(
          child: IconButton(
              onPressed: () {
                Get.to(
                  SettingsScreen(),
                  transition: Transition.circularReveal,
                  duration: Duration(seconds: 2),
                );
              },
              icon: const Icon(
                Icons.settings,
              )),
        ),
      ],
    );
  }
}
