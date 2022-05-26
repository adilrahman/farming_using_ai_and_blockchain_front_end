import 'package:flutter/material.dart';

// it include every customized textFields  as different classess

class GeneralTextField extends StatelessWidget {
  const GeneralTextField(
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
            margin: const EdgeInsets.symmetric(horizontal: 25),
            padding: const EdgeInsets.all(0),
            decoration: BoxDecoration(
                color: Colors.grey[600]!.withOpacity(.5),
                borderRadius: BorderRadius.circular(100)),
            child: TextField(
                controller: _textEditingController,
                style: const TextStyle(color: Colors.white),
                obscureText: _isPassword,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.only(top: 15),
                  hintText: _hintText,
                  hintStyle: const TextStyle(color: Colors.white30),
                  border: InputBorder.none,
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: _prefixIcon,
                  ),
                )),
          )
        ],
      ),
    );
  }
}
