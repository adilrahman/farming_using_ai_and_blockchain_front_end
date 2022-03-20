import 'package:farming_using_ai_and_blockchain_front_end/palatte.dart';
import 'package:farming_using_ai_and_blockchain_front_end/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class InvestorsSignInScreen extends StatelessWidget {
  // Investors Sign in Screen
  InvestorsSignInScreen({Key? key}) : super(key: key);
  TextEditingController _userEthAddress = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BackgroundImageOfInvestorSign(),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              child: Text(
                "Investor",
                style: kHeading,
              ),
            ),
            SizedBox(
              height: 50,
            ),
            GeneralTextField(
                textEditingController: _userEthAddress,
                hintText: "ethereum address",
                prefixIcon: Icon(FontAwesomeIcons.ethereum)),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Colors.green[500],
                    padding:
                        EdgeInsets.symmetric(horizontal: 70, vertical: 15)),
                onPressed: () {
                  print(_userEthAddress.text);
                },
                child: const Text("Login"))
          ],
        ),
      ],
    );
  }
}
