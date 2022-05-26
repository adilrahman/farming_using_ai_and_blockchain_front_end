import 'package:farming_using_ai_and_blockchain_front_end/screens/screens.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SafeArea(
            child: ListView(
          padding: const EdgeInsets.only(top: 270, left: 24, right: 24),
          children: [
            SettingsGroup(title: "General", children: [
              buildLogout(),
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
        child: const Icon(Icons.cancel),
      ),
    );
  }

  final Color _color = Colors.blue;
  final _icon = const Icon(
    Icons.logout_rounded,
  );

  Widget buildLogout() => SimpleSettingsTile(
      title: "Logout",
      subtitle: '',
      leading: SettingsPageIcon(color: _color, icon: _icon),
      onTap: () => logout());
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
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _color,
      ),
      child: _icon,
    );
  }
}

logout() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool? isInvesterLogged = prefs.getBool('investerLogged');

  if (isInvesterLogged == true) {
    Get.offAll(InvestorsSignInScreen(),
        duration: const Duration(seconds: 3), transition: Transition.topLevel);
  } else {
    await FirebaseAuth.instance.signOut();
    Get.offAll(SignInOrSignUp(),
        duration: const Duration(seconds: 3), transition: Transition.topLevel);
  }

  await prefs.clear();
}
