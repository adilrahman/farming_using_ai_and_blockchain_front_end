import 'package:flutter/material.dart';

class TextFieldWithSuffix extends StatelessWidget {
  const TextFieldWithSuffix({
    Key? key,
    required TextEditingController titleEditingController,
    required String suffixText,
    required IconData icon,
    required String hintText,
    required currentValue,
  })  : _titleEditingController = titleEditingController,
        _suffixText = suffixText,
        _icon = icon,
        _hintText = hintText,
        _currentValue = currentValue,
        super(key: key);

  final TextEditingController _titleEditingController;
  final String _suffixText;
  final IconData _icon;
  final String _hintText;
  final _currentValue;

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: const TextStyle(color: Colors.black),
      controller: _titleEditingController,
      decoration: InputDecoration(
        suffixText: _suffixText,
        suffixIcon: IconButton(
          onPressed: () {
            _titleEditingController.text = _currentValue.toString();
          },
          icon: Icon(
            _icon,
            color: Colors.black87,
          ),
        ),
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

class projectDescriptionField extends StatelessWidget {
  const projectDescriptionField({
    Key? key,
    required TextEditingController descriptionEditingController,
  })  : _descriptionEditingController = descriptionEditingController,
        super(key: key);

  final TextEditingController _descriptionEditingController;

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: const TextStyle(color: Colors.black),
      // descriton field
      controller: _descriptionEditingController,
      decoration: const InputDecoration(
          labelStyle: TextStyle(color: Colors.black),
          hintStyle: TextStyle(fontSize: 15.0, color: Colors.grey),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey, width: 1.0),
          ),
          border: OutlineInputBorder(),
          hintText: "Project Description"),
      maxLines: 10,
      keyboardType: TextInputType.multiline,
    );
  }
}

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
