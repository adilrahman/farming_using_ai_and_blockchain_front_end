import 'package:farming_using_ai_and_blockchain_front_end/palatte.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// it include every customized textFields  as different classess

class TextFieldPassword extends StatelessWidget {
  // this is password custom textfield
  const TextFieldPassword({
    Key? key,
    required TextEditingController passwordEditController,
  })  : _passwordEditController = passwordEditController,
        super(key: key);

  final TextEditingController _passwordEditController;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey[600]?.withOpacity(0.5),
          borderRadius: BorderRadius.circular(40)),
      child: TextField(
        controller: _passwordEditController,
        obscureText: true,
        textInputAction: TextInputAction.done,
        style: const TextStyle(color: Colors.white),
        decoration: const InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 18),
            prefixIcon: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Icon(Icons.lock_outline)),
            hintStyle: TextStyle(),
            hintText: "Password",
            border: InputBorder.none),
      ),
    );
  }
}

class TextFieldUserName extends StatelessWidget {
  // this is username custom textfield
  TextFieldUserName(
      {Key? key,
      required TextEditingController userNameEditController,
      required String newhintText})
      : _userNameEditController = userNameEditController,
        _hintText = newhintText,
        super(key: key);

  final TextEditingController _userNameEditController;
  final String _hintText;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey[600]?.withOpacity(0.5),
          borderRadius: BorderRadius.circular(40)),
      child: TextField(
        controller: _userNameEditController,
        keyboardType: TextInputType.name,
        textInputAction: TextInputAction.next,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(vertical: 18),
            prefixIcon: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Icon(Icons.person_outline),
            ),
            hintStyle: TextStyle(),
            hintText: _hintText,
            border: InputBorder.none),
      ),
    );
  }
}
