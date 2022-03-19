import 'package:farming_using_ai_and_blockchain_front_end/color_constants.dart';
import 'package:farming_using_ai_and_blockchain_front_end/palatte.dart';
import 'package:farming_using_ai_and_blockchain_front_end/screens/screens.dart';
import 'package:farming_using_ai_and_blockchain_front_end/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({Key? key}) : super(key: key);

  //only sign in screen

  @override
  Widget build(BuildContext context) {
    TextEditingController _userNameEditController = TextEditingController();
    TextEditingController _passwordEditController = TextEditingController();
    return Container(
      padding: const EdgeInsets.only(left: 15, right: 15, top: 2, bottom: 15),
      child: SingleChildScrollView(
        child: (Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Container(
              height: 150,
              width: 285,
              // Background Icon
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/login_icon.png"),
                      fit: BoxFit.fill)),
              // Image.asset("assets/images/login_icon.png"),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              //user name , passwrod and login button
              padding: const EdgeInsets.only(
                left: 20,
                right: 20,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFieldUserName(
                      newhintText: "Username",
                      userNameEditController: _userNameEditController),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFieldPassword(
                      passwordEditController: _passwordEditController),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.green[500],
                          textStyle: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                          padding: EdgeInsets.symmetric(
                              horizontal: 100, vertical: 13)),
                      onPressed: () {
                        print(_userNameEditController.text);
                        print(_passwordEditController.text);
                        Get.to(HomeScreen(), transition: Transition.zoom);
                      },
                      child: const Text("Login"))
                ],
              ),
            ),
          ],
        )),
      ),
    );
  }
}
