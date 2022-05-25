import 'package:farming_using_ai_and_blockchain_front_end/data_model/crowdfunding/functions/crowdfunding_investors_functions.dart';
import 'package:farming_using_ai_and_blockchain_front_end/palatte.dart';
import 'package:farming_using_ai_and_blockchain_front_end/screens/investors_screen/investors_screen.dart';
import 'package:farming_using_ai_and_blockchain_front_end/screens/settings/settings_screen.dart';
import 'package:farming_using_ai_and_blockchain_front_end/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/instance_manager.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../data_model/invsetor/functions/lnvestor_loggin.dart';
import '../../data_model/invsetor/investor_data_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InvestorsSignInScreen extends StatelessWidget {
  // Investors Sign in Screen
  InvestorsSignInScreen({Key? key}) : super(key: key);
  final TextEditingController _userEthAddress = TextEditingController();
  final TextEditingController _username = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const BackgroundImageOfInvestorSign(),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                child: const Text(
                  "Investor",
                  style: kHeading,
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              GeneralTextField(
                  textEditingController: _username,
                  hintText: "name",
                  prefixIcon: const Icon(Icons.person_outline)),
              const SizedBox(
                height: 15,
              ),
              GeneralTextField(
                  textEditingController: _userEthAddress,
                  hintText: "ethereum address",
                  prefixIcon: const Icon(FontAwesomeIcons.ethereum)),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.green[500],
                      padding: const EdgeInsets.symmetric(
                          horizontal: 70, vertical: 15)),
                  onPressed: () {
                    login();
                  },
                  child: const Text("Login"))
            ],
          ),
        ],
      ),
    );
  }

  login() async {
    final ethAddressFormat = RegExp(r'^0x[a-fA-F0-9]{40}$');
    if (_username.text == "" || _userEthAddress.text == "") {
      Get.snackbar("Error", "username and password must not be null");
      return;
    }
    if (_username.text.length > 4) {
      Get.snackbar("Error", "username must be greater than 4 characters");
      return;
    }

    if (!ethAddressFormat.hasMatch(_userEthAddress.text)) {
      Get.snackbar("Etherium Address Error", "Not a valid etherium address");
      return;
    }

    final loginfo =
        LogInfo(userName: _username.text, etherAddress: _userEthAddress.text);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('investerLogged', true);
    prefs.setString('username', _username.text);

    prefs.setString('ethAddress', _userEthAddress.text);

    Get.off(
      InvestorsScreen(logInfo: loginfo),
      transition: Transition.circularReveal,
      duration: const Duration(seconds: 2),
    );
  }

  // isLoggin() async {
  //   if (await isLoggined()) {
  //     Get.to(
  //       const InvestorsScreen(),
  //       transition: Transition.circularReveal,
  //       duration: const Duration(seconds: 2),
  //     );
  //   }
  // }
}

class LogInfo {
  String etherAddress;
  String userName;
  LogInfo({required this.userName, required this.etherAddress});
}
