import 'package:farming_using_ai_and_blockchain_front_end/palatte.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// it include every customized textFields  as different classess

class GeneralTextField extends StatelessWidget {
  GeneralTextField(
      {Key? key,
      required TextEditingController textEditingController,
      required String hintText,
      required Icon prefixIcon,
      bool isPassword = false})
      : _textEditingController = textEditingController,
        _hintText = hintText,
        _prefixIcon = prefixIcon,
        _isPassword = isPassword,
        super(key: key);

  final TextEditingController _textEditingController;
  final String _hintText;
  final Icon _prefixIcon;
  final bool _isPassword;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 25),
            padding: EdgeInsets.all(0),
            decoration: BoxDecoration(
                color: Colors.grey[600]!.withOpacity(.5),
                borderRadius: BorderRadius.circular(100)),
            child: TextField(
                controller: _textEditingController,
                style: const TextStyle(color: Colors.white),
                obscureText: _isPassword,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(top: 15),
                  hintText: _hintText,
                  hintStyle: TextStyle(color: Colors.white30),
                  border: InputBorder.none,
                  prefixIcon: Padding(
                    padding: EdgeInsets.all(14.0),
                    child: _prefixIcon,
                  ),
                )),
          )
        ],
      ),
    );
  }
}
