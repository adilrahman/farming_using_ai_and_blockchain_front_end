import 'package:farming_using_ai_and_blockchain_front_end/palatte.dart';
import 'package:farming_using_ai_and_blockchain_front_end/widgets/widgets.dart';
import 'package:flutter/material.dart';

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
            TextFieldUserName(
              userNameEditController: _userEthAddress,
              newhintText: "Etherium Address",
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Colors.green,
                    textStyle: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 100, vertical: 18)),
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
