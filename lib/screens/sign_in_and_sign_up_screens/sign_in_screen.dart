import 'dart:developer';

import 'package:farming_using_ai_and_blockchain_front_end/color_constants.dart';
import 'package:farming_using_ai_and_blockchain_front_end/palatte.dart';
import 'package:farming_using_ai_and_blockchain_front_end/screens/screens.dart';
import 'package:farming_using_ai_and_blockchain_front_end/widgets/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({Key? key}) : super(key: key);

  //only sign in screen
  final _auth = FirebaseAuth.instance;
  TextEditingController _emailEditController = TextEditingController();
  TextEditingController _passwordEditController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 0, right: 0, top: 2, bottom: 15),
      child: SingleChildScrollView(
        child: (Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Container(
              height: 150,
              width: 285,
              // Background Icon
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/login_icon.png"),
                      fit: BoxFit.fill)),
              // Image.asset("assets/images/login_icon.png"),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              //user name , passwrod and login button
              padding: const EdgeInsets.only(
                left: 5,
                right: 5,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GeneralTextField(
                      textEditingController: _emailEditController,
                      hintText: "email",
                      prefixIcon: const Icon(Icons.email_outlined)),
                  const SizedBox(
                    height: 10,
                  ),
                  GeneralTextField(
                    textEditingController: _passwordEditController,
                    hintText: "password",
                    prefixIcon: const Icon(Icons.lock_outline),
                    isPassword: true,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.green[500],
                          padding: const EdgeInsets.symmetric(
                              horizontal: 70, vertical: 15)),
                      onPressed: () {
                        // print(_userNameEditController.text);
                        // print(_passwordEditController.text);
                        signIn(
                            email: _emailEditController.text,
                            password: _passwordEditController.text);
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

  void signIn({required String email, required String password}) async {
    log(email);
    log(password);

    await _auth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((uid) => {
              Get.snackbar("Login", "Successfull"),
              Get.to(HomeScreen(),
                  transition: Transition.cupertinoDialog,
                  duration: const Duration(milliseconds: 1200))
            })
        .catchError((e) {
      Get.snackbar("Error", e.toString());
    });
  }
}
