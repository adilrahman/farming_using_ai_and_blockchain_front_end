import 'package:farming_using_ai_and_blockchain_front_end/screens/settings/settings_screen.dart';
import 'package:flutter/material.dart';
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
                  const SettingsScreen(),
                  transition: Transition.circularReveal,
                  duration: const Duration(seconds: 2),
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
