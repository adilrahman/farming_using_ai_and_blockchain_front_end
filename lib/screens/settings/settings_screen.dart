import 'package:farming_using_ai_and_blockchain_front_end/color_constants.dart';
import 'package:farming_using_ai_and_blockchain_front_end/main.dart';
import 'package:farming_using_ai_and_blockchain_front_end/screens/screens.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:liquid_swipe/liquid_swipe.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SafeArea(
            child: ListView(
          padding: EdgeInsets.only(top: 270, left: 24, right: 24),
          children: [
            SettingsGroup(title: "General", children: [
              buildLogout(),
              buildDeleteAccount(),
            ])
          ],
        )),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.grey,
        onPressed: () {
          Get.back();
        },
        child: Icon(Icons.cancel),
      ),
    );
  }

  Color _color = Colors.blue;
  var _icon = Icon(
    Icons.logout_rounded,
  );

  Widget buildLogout() => SimpleSettingsTile(
        title: "Logout",
        subtitle: '',
        leading: SettingsPageIcon(color: _color, icon: _icon),
        onTap: () => Get.offAll(SignInOrSignUp(),
            duration: Duration(seconds: 3), transition: Transition.topLevel),
      );

  Widget buildDeleteAccount() => SimpleSettingsTile(
        title: "Delete Account",
        subtitle: '',
        leading: SettingsPageIcon(
          color: Colors.red,
          icon: Icon(Icons.delete),
        ),
      );
}

class SettingsPageIcon extends StatelessWidget {
  const SettingsPageIcon({
    Key? key,
    required Color color,
    required Icon icon,
  })  : _color = color,
        _icon = icon,
        super(key: key);

  final Color _color;
  final Icon _icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _color,
      ),
      child: _icon,
    );
  }
}
