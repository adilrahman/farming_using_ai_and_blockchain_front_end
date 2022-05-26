import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farming_using_ai_and_blockchain_front_end/data_model/registration/user_model.dart';
import 'package:farming_using_ai_and_blockchain_front_end/widgets/text_fields.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatelessWidget {
  //sign up screen
  SignUpScreen({Key? key}) : super(key: key);

  final _auth = FirebaseAuth.instance;

  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  TextEditingController _ethereumAddressController = TextEditingController();
  TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.only(top: 70),
        child: Column(
          children: [
            GeneralTextField(
                textEditingController: _usernameController,
                hintText: "username",
                prefixIcon: const Icon(Icons.person_outline)),
            const SizedBox(
              height: 15,
            ),
            GeneralTextField(
                textEditingController: _emailController,
                hintText: "email",
                prefixIcon: const Icon(Icons.email_outlined)),
            const SizedBox(
              height: 15,
            ),
            GeneralTextField(
                textEditingController: _ethereumAddressController,
                hintText: "ethereum address",
                prefixIcon: const Icon(FontAwesomeIcons.ethereum)),
            const SizedBox(
              height: 15,
            ),
            GeneralTextField(
              textEditingController: _passwordController,
              hintText: "password",
              prefixIcon: const Icon(Icons.lock_outline),
              isPassword: true,
            ),
            const SizedBox(
              height: 15,
            ),
            GeneralTextField(
              textEditingController: _confirmPasswordController,
              hintText: "confirm password",
              prefixIcon: const Icon(Icons.lock),
              isPassword: true,
            ),
            const SizedBox(
              height: 15,
            ),
            ElevatedButton(
              onPressed: () {
                signUp(
                    cnfPassword: _confirmPasswordController.text,
                    email: _emailController.text,
                    ethAddress: _ethereumAddressController.text,
                    password: _passwordController.text,
                    userName: _usernameController.text);
              },
              child: const Text("Sign Up"),
              style: ElevatedButton.styleFrom(
                  primary: Colors.green[70],
                  padding:
                      const EdgeInsets.symmetric(horizontal: 70, vertical: 15)),
            )
          ],
        ),
      ),
    );
  }

  void signUp({
    required String email,
    required String userName,
    required String ethAddress,
    required String password,
    required String cnfPassword,
  }) async {
    final ethAddressFormat = RegExp(r'^0x[a-fA-F0-9]{40}$');
    final emailAddressFormat = RegExp(r'^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+$');

    if (password != cnfPassword) {
      Get.snackbar("Password Error", "Both passwords are not same");
      return;
    }
    if (password.length < 6) {
      Get.snackbar("Password Error", "Password must be more than 5 ");
      return;
    }
    if (!ethAddressFormat.hasMatch(ethAddress)) {
      Get.snackbar("Etherium Address Error", "Not a valid etherium address");
      return;
    }

    if (!emailAddressFormat.hasMatch(email)) {
      Get.snackbar("email Address Error", "Not a valid email address");
      return;
    }

    await _auth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) => postDetailsToFireStrore(
            email: email, ethAddress: ethAddress, userName: userName))
        .catchError((e) {
      Get.snackbar("Firebase Error", e.toString());
    });
  }

  postDetailsToFireStrore(
      {required email, required ethAddress, required userName}) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

    User? user = _auth.currentUser;

    UserModel userModel = UserModel(
        userId: user!.uid,
        email: email,
        ethAddress: ethAddress,
        userName: userName);

    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .set(userModel.toMap())
        .then((value) {
      Get.snackbar("Account Created", "Account created successfully");
    }).catchError((e) {
      Get.snackbar("Firebase Error", e.toString());
    });
  }
}
