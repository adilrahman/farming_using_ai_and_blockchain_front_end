import 'package:flutter/material.dart';

class singleTextField extends StatelessWidget {
  const singleTextField({
    Key? key,
    required TextEditingController titleEditingController,
    required String hintText,
  })  : _titleEditingController = titleEditingController,
        _hintText = hintText,
        super(key: key);

  final TextEditingController _titleEditingController;
  final String _hintText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      // Title field
      style: const TextStyle(color: Colors.black),
      controller: _titleEditingController,
      decoration: InputDecoration(
        labelStyle: const TextStyle(color: Colors.black),
        hintStyle: const TextStyle(fontSize: 15.0, color: Colors.grey),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey, width: 1.0),
        ),
        border: const OutlineInputBorder(),
        hintText: _hintText,
      ),
    );
  }
}
