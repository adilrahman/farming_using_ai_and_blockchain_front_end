import 'package:farming_using_ai_and_blockchain_front_end/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
              onPressed: () {},
              icon: const Icon(
                Icons.settings,
              )),
        ),
      ],
    );
  }
}
