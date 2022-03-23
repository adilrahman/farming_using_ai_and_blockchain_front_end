import 'package:farming_using_ai_and_blockchain_front_end/color_constants.dart';
import 'package:farming_using_ai_and_blockchain_front_end/widgets/text_fields.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SignUpScreen extends StatelessWidget {
  //sign up screen
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController _usernameController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();
    TextEditingController _confirmPasswordController = TextEditingController();
    TextEditingController _ethereumAddressController = TextEditingController();

    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.only(top: 70),
        child: Column(
          children: [
            GeneralTextField(
                textEditingController: _usernameController,
                hintText: "username",
                prefixIcon: Icon(Icons.person_outline)),
            SizedBox(
              height: 15,
            ),
            GeneralTextField(
                textEditingController: _ethereumAddressController,
                hintText: "ethereum address",
                prefixIcon: Icon(FontAwesomeIcons.ethereum)),
            SizedBox(
              height: 15,
            ),
            GeneralTextField(
              textEditingController: _passwordController,
              hintText: "password",
              prefixIcon: Icon(Icons.lock_outline),
              isPassword: true,
            ),
            SizedBox(
              height: 15,
            ),
            GeneralTextField(
              textEditingController: _confirmPasswordController,
              hintText: "confirm password",
              prefixIcon: Icon(Icons.lock),
              isPassword: true,
            ),
            SizedBox(
              height: 15,
            ),
            ElevatedButton(
              onPressed: () {},
              child: Text("Sign Up"),
              style: ElevatedButton.styleFrom(
                  primary: Colors.green[70],
                  padding: EdgeInsets.symmetric(horizontal: 70, vertical: 15)),
            )
          ],
        ),
      ),
    );
  }
}
