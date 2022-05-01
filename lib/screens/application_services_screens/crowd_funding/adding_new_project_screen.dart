import 'package:flutter/material.dart';

class addingNewProjectScreen extends StatelessWidget {
  const addingNewProjectScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController _titleEditingController =
        TextEditingController();
    final TextEditingController _descriptionEditingController =
        TextEditingController();
    final _hintText = "Title";
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 10),
              singleTextField(
                  titleEditingController: _titleEditingController,
                  hintText: "project name"),
              const SizedBox(height: 10),
              singleTextField(
                  titleEditingController: _titleEditingController,
                  hintText: "project name"),
              const SizedBox(height: 10),
              projectDescriptionField(
                  descriptionEditingController: _descriptionEditingController)
            ],
          ),
        ),
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
